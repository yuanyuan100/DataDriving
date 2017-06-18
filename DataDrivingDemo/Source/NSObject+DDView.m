//
//  NSObject+DDView.m
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/15.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "NSObject+DDView.h"
#import "NSString+DDSet.h"
#import "NSString+DD_Char.h"
#import "NSObject+DDAddress.h"

#import <objc/runtime.h>

#import "DDKVOCenter.h"

@class ViewControllerModel;

NS_ASSUME_NONNULL_BEGIN

static void *NSObjectDD_ViewKVOCenterSet = &NSObjectDD_ViewKVOCenterSet;
static void *NSObjectDD_SelfFlag = &NSObjectDD_SelfFlag;

DDKeyValueDataFlowKey const DDKeyValueDataWillFlowKey     = @"will";
DDKeyValueDataFlowKey const DDKeyValueDataDidFlowKey      = @"did";
DDKeyValueDataFlowKey const DDKeyValueDataFlowNewKey      = @"new";
DDKeyValueDataFlowKey const DDKeyValueDataFlowOldKey      = @"old";

@interface NSObject ()
@property (nonatomic, strong) NSMutableDictionary<NSString*, DDKVOCenter *> *DD_KVOCenterSet;

/**
 改变是否来自 自己先改变被绑定者，被绑定者的改变又来改变自己。if YES 自己不在改变 防止循环KVO
 */
@property (nonatomic, getter=isDD_SelfFlag) BOOL DD_SelfFlag;
@end

@implementation NSObject (DDView)

#pragma mark - 添加观察者
- (void)dd_bindObject:(id)object bothPath:(NSString *)path {
    [self dd_bindObject:object bothPath:path positive:nil reverse:nil];
}

- (void)dd_bindObject:(id)object bothPath:(NSString *)path showNow:(BOOL)showNow {
    [self dd_bindObject:object bothPath:path positive:nil reverse:nil showNow:showNow];
}

- (void)dd_bindObject:(id)object oPath:(NSString *)oPath mPath:(NSString *)mPath {
    [self dd_bindObject:object oPath:oPath mPath:mPath positive:nil reverse:nil];
}

- (void)dd_bindObject:(id)object oPath:(NSString *)oPath mPath:(NSString *)mPath showNow:(BOOL)showNow {
    [self dd_bindObject:object oPath:oPath mPath:mPath positive:nil reverse:nil showNow:showNow];
}

- (void)dd_bindObject:(id)object
             bothPath:(NSString *)path
             positive:(nullable BOOL (^)(NSDictionary<DDKeyValueDataFlowKey,id> *))positive
              reverse:(nullable BOOL (^)(NSDictionary<DDKeyValueDataFlowKey,id> *))reverse
{
    [self dd_bindObject:object oPath:path mPath:path positive:positive reverse:reverse];
}

- (void)dd_bindObject:(id)object
             bothPath:(NSString *)path
             positive:(nullable BOOL (^)(NSDictionary<DDKeyValueDataFlowKey,id> *))positive
              reverse:(nullable BOOL (^)(NSDictionary<DDKeyValueDataFlowKey,id> *))reverse
              showNow:(BOOL)showNow
{
    [self dd_bindObject:object oPath:path mPath:path positive:positive reverse:reverse showNow:showNow];
}

- (void)dd_bindObject:(id)object
                oPath:(NSString *)oPath
                mPath:(NSString *)mPath
             positive:(nullable BOOL (^)(NSDictionary<DDKeyValueDataFlowKey,id> *))positive
              reverse:(nullable BOOL (^)(NSDictionary<DDKeyValueDataFlowKey,id> *))reverse
{
    [self dd_bindObject:object oPath:oPath mPath:mPath positive:positive reverse:reverse showNow:false];
}

- (void)dd_bindObject:(id)object
                oPath:(NSString *)oPath
                mPath:(NSString *)mPath
             positive:(nullable BOOL (^)(NSDictionary<DDKeyValueDataFlowKey,id> *))positive
              reverse:(nullable BOOL (^)(NSDictionary<DDKeyValueDataFlowKey,id> *))reverse
              showNow:(BOOL)showNow
{
    NSAssert(nil != object && 0 != oPath.length && 0 != mPath.length, @"dd_bindObject:%@\
             oPath:%@\
             mPath:%@\
             positive:%p\
             reverse:%p",
             object, oPath, mPath, positive, reverse);
    
    if (nil == object || 0 == oPath.length || 0 == mPath.length) {
        return;
    } else {
        // 判断是否满足 属性的get set方法
        if (false == [self respondsToSelector:mPath.dd_propertySetMethod]) {
            NSAssert(false, @"%@ 不满足set方法", mPath);
            return;
        }
        if (false == [self respondsToSelector:mPath.dd_propertyGetMethod]) {
            NSAssert(false, @"%@ 不满足get方法", mPath);
            return;
        }
        if (false == [object respondsToSelector:oPath.dd_propertySetMethod]) {
            NSAssert(false, @"%@ 不满足set方法", oPath);
            return;
        }
        if (false == [object respondsToSelector:oPath.dd_propertyGetMethod]) {
            NSAssert(false, @"%@ 不满足get方法", oPath);
            return;
        }
    }
    
    // 判断字典中是否已经存在绑定
    // 只需要任意查看被绑定者或model 的KVOCenter是否存在字典中即可
    // 找到被绑定者
    NSString *o = [[oPath dd_addressObject:object changed:self] dd_addDiff:DDSetDiffO];
    if (nil != [self.DD_KVOCenterSet objectForKey:o]) {
        NSAssert(NO, @"%@已经绑定在%@", object, self);
        return;
    }
    
    // 绑定时立即赋值
    if (true == showNow) {
        id mValue = [self valueForKey:mPath];
        NSAssert(nil != mValue, @"%@的%@属性为nil", self, mPath);
        if (nil != mValue) {
            [object setValue:mValue forKey:oPath];
        }
    }
    
    [self addObserverd:self oPath:mPath changed:object cPath:oPath block:positive diff:DDSetDiffM];
    
    [self addObserverd:object oPath:oPath changed:self cPath:mPath block:reverse diff:DDSetDiffO];
    
}


/**
 添加被观察者

 @param observerd 被观察者
 @param oPath 悲观者这属性
 @param changed 双向绑定的被改变者
 @param cPath 被改变者的属性
 @param block KVO回调
 @param diff 区别DDKVOCenter实例对象存入字典的key，以防双向绑定的属性名相同
 */
- (void)addObserverd:(id)observerd oPath:(NSString *)oPath changed:(id)changed cPath:(NSString *)cPath block:(nullable BOOL (^)(NSDictionary<DDKeyValueDataFlowKey,id> *))block diff:(DDSetDiff)diff {
    
    __weak typeof(changed) weakChanged = changed;
    __weak typeof(self) weakSelf = self;
    DDKVOCenter *kvoCenter = [DDKVOCenter new];
    [kvoCenter observed:observerd keyPath:oPath options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        // 是否执行KVC赋值操作
        BOOL executeKVC = true;
        
        if (block) {
            executeKVC = block(@{
                                   DDKeyValueDataWillFlowKey:@true,
                                   DDKeyValueDataFlowNewKey:change[NSKeyValueChangeNewKey],
                                   DDKeyValueDataFlowOldKey:change[NSKeyValueChangeOldKey]
                                   });
        }
        if (true == executeKVC) {
            // 观察到object 属性发生变化
            if (false == [weakChanged isEqual:weakSelf] || false == self.isDD_SelfFlag) {
                self.DD_SelfFlag = true;
                [weakChanged setValue:change[NSKeyValueChangeNewKey] forKey:cPath];
            } else {
                self.DD_SelfFlag = false;
            }
            
            if (block) {
                block(@{
                        DDKeyValueDataDidFlowKey:@true,
                        DDKeyValueDataFlowNewKey:change[NSKeyValueChangeNewKey],
                        DDKeyValueDataFlowOldKey:change[NSKeyValueChangeOldKey]
                        });
            }
        }
        
    }];
    [self.DD_KVOCenterSet setObject:kvoCenter forKey:[[oPath dd_addressObject:observerd changed:changed] dd_addDiff:diff]];
}

#pragma mark - 移除观察者
- (void)dd_removeBind:(id)object bothPath:(NSString *)path {
    [self dd_removeBind:object oPath:path mPath:path];
}

- (void)dd_removeBind:(id)object oPath:(NSString *)oPath mPath:(NSString *)mPath {
    NSAssert(nil != object && 0 != oPath.length && 0 != mPath.length, @"dd_removeBind:%@ oPath:%@ mPath:%@", object, oPath, mPath);
    
    if (nil == object || 0 == oPath.length || 0 == mPath.length) {
        return;
    }
    
    // 移除被绑定者
    NSString *o = [[oPath dd_addressObject:object changed:self] dd_addDiff:DDSetDiffO];
    [self.DD_KVOCenterSet[o] removeobserved:object keyPath:oPath];
    [self.DD_KVOCenterSet removeObjectForKey:o];
    
    // 移除model
    NSString *m = [[mPath dd_addressObject:self changed:object] dd_addDiff:DDSetDiffM];
    [self.DD_KVOCenterSet[m] removeobserved:self keyPath:mPath];
    [self.DD_KVOCenterSet removeObjectForKey:m];
}

#pragma mark - setter or getter
- (void)setDD_KVOCenterSet:(NSMutableDictionary<NSString *,DDKVOCenter *> *)DD_KVOCenterSet {
    objc_setAssociatedObject(self, NSObjectDD_ViewKVOCenterSet, DD_KVOCenterSet, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary<NSString *,DDKVOCenter *> *)DD_KVOCenterSet {
    id set = objc_getAssociatedObject(self, NSObjectDD_ViewKVOCenterSet);
    if (nil == set) {
        set = [[NSMutableDictionary alloc] init];
        self.DD_KVOCenterSet = set;
    }
    return set;
}

- (void)setDD_SelfFlag:(BOOL)DD_SelfFlag {
    if (self.isDD_SelfFlag != DD_SelfFlag) {
        objc_setAssociatedObject(self, NSObjectDD_SelfFlag, [NSNumber numberWithBool:DD_SelfFlag], OBJC_ASSOCIATION_ASSIGN);
    }
}

- (BOOL)isDD_SelfFlag {
    id flag = objc_getAssociatedObject(self, NSObjectDD_SelfFlag);
    return [(NSNumber *)flag boolValue];
}

@end

NS_ASSUME_NONNULL_END
