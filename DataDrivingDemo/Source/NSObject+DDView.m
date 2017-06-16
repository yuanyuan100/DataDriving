//
//  NSObject+DDView.m
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/15.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "NSObject+DDView.h"
#import "NSString+DDSet.h"

#import <objc/runtime.h>

#import "DDKVOCenter.h"

@class ViewControllerModel;

NS_ASSUME_NONNULL_BEGIN

static void *NSObjectDD_ViewKVOCenterSet = &NSObjectDD_ViewKVOCenterSet;

DDKeyValueDataFlowKey const DDKeyValueDataWillFlowKey     = @"will";
DDKeyValueDataFlowKey const DDKeyValueDataDidFlowKey      = @"did";
DDKeyValueDataFlowKey const DDKeyValueDataFlowNewKey      = @"new";
DDKeyValueDataFlowKey const DDKeyValueDataFlowOldKey      = @"old";

@interface NSObject ()
@property (nonatomic, strong) NSMutableDictionary<NSString*, DDKVOCenter *> *DD_KVOCenterSet;
@end

@implementation NSObject (DDView)

#pragma mark - 添加观察者
- (void)dd_bindObject:(id)object
             bothPath:(NSString *)path
             positive:(nullable void (^)(NSDictionary<DDKeyValueDataFlowKey,id> *))positive
              reverse:(nullable void (^)(NSDictionary<DDKeyValueDataFlowKey,id> *))reverse
{
    [self dd_bindObject:object oPath:path mPath:path positive:positive reverse:reverse];
}

- (void)dd_bindObject:(id)object
                oPath:(NSString *)oPath
                mPath:(NSString *)mPath
             positive:(nullable void (^)(NSDictionary<DDKeyValueDataFlowKey,id> *))positive
              reverse:(nullable void (^)(NSDictionary<DDKeyValueDataFlowKey,id> *))reverse
{
    NSAssert(nil != object && 0 != oPath.length && 0 != mPath.length, @"dd_bindObject:%@\
             oPath:%@\
             mPath:%@\
             positive:%p\
             reverse:%p",
             object, oPath, mPath, positive, reverse);
    
    if (nil == object || 0 == oPath.length || 0 == mPath.length) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(object) weakObject = object;
    
    DDKVOCenter *mKvoCenter = [DDKVOCenter new];
    [mKvoCenter observed:self keyPath:mPath options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        if (positive) {
            positive(@{
                       DDKeyValueDataWillFlowKey:@true,
                       DDKeyValueDataFlowNewKey:change[NSKeyValueChangeNewKey],
                       DDKeyValueDataFlowOldKey:change[NSKeyValueChangeOldKey]
                       });
        }
        
        // 观察到model 属性发生变化
        SEL oSel = NSSelectorFromString(oPath.dd_appendingSet);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [weakObject performSelector:oSel withObject:change[NSKeyValueChangeNewKey]];
#pragma clang diagnostic pop
        if (positive) {
            positive(@{
                       DDKeyValueDataDidFlowKey:@true,
                       DDKeyValueDataFlowNewKey:change[NSKeyValueChangeNewKey],
                       DDKeyValueDataFlowOldKey:change[NSKeyValueChangeOldKey]
                       });
        }
    }];
    [self.DD_KVOCenterSet setObject:mKvoCenter forKey:mPath];
    
//    SEL mSel = NSSelectorFromString(mPath.dd_appendingSet);
//    [self performSelector:mSel withObject:@"44444444"];
    
    DDKVOCenter *oKvoCenter = [DDKVOCenter new];
    [oKvoCenter observed:object keyPath:oPath options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        
        if (reverse) {
            reverse(@{
                       DDKeyValueDataWillFlowKey:@true,
                       DDKeyValueDataFlowNewKey:change[NSKeyValueChangeNewKey],
                       DDKeyValueDataFlowOldKey:change[NSKeyValueChangeOldKey]
                       });
        }
        
        // 观察到object 属性发生变化
//        SEL mSel = NSSelectorFromString(mPath.dd_appendingSet);
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//        if ([weakSelf respondsToSelector:mSel]) {
//            [weakSelf performSelector:mSel withObject:change[NSKeyValueChangeNewKey]];
//        }
        
        [weakSelf setValue:change[NSKeyValueChangeNewKey] forKey:[NSString stringWithFormat:@"_%@", mPath]];
#pragma clang diagnostic pop
        if (reverse) {
            reverse(@{
                       DDKeyValueDataDidFlowKey:@true,
                       DDKeyValueDataFlowNewKey:change[NSKeyValueChangeNewKey],
                       DDKeyValueDataFlowOldKey:change[NSKeyValueChangeOldKey]
                       });
        }
        
    }];
    [self.DD_KVOCenterSet setObject:oKvoCenter forKey:oPath];
    
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
    
    [self.DD_KVOCenterSet[oPath] removeobserved:object keyPath:oPath];
    [self.DD_KVOCenterSet removeObjectForKey:oPath];
    
    [self.DD_KVOCenterSet[mPath] removeobserved:self keyPath:mPath];
    [self.DD_KVOCenterSet removeObjectForKey:mPath];
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

@end

NS_ASSUME_NONNULL_END
