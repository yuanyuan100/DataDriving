//
//  NSObject+DDNet.m
//  DataDrivingDemo
//
//  Created by Mr.Pyy on 2017/6/15.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "NSObject+DDNet.h"

#import <objc/runtime.h>

#import "DDNetObject.h"

#import "DDNetParse.h"


NS_ASSUME_NONNULL_BEGIN

static void *NSObjectDD_askNetKey = &NSObjectDD_askNetKey;
static void *NSObjectDD_askNetFlagKey = &NSObjectDD_askNetFlagKey;
static void *NSObjectDD_uploadNetKey = &NSObjectDD_uploadNetKey;
static void *NSObjectDD_uploadFlagNetKey = &NSObjectDD_uploadFlagNetKey;
static void *NSObjectDD_OperationKey = &NSObjectDD_OperationKey;
static void *NSObjectDD_OperationtFlagKey = &NSObjectDD_OperationtFlagKey;
static void *NSObjectDD_DelegatesKey = &NSObjectDD_DelegatesKey;

static void *NSObjectdd_OperationKey = &NSObjectdd_OperationKey;
static void *NSObjectdd_indexSKey = &NSObjectdd_indexSKey;
static void *NSObjectdd_modelSKey = &NSObjectdd_modelSKey;


@interface NSObject ()
@property (nonatomic ,strong) NSMutableArray<DDNetObject *> *DD_Delegates;
/**
 拉取网络请求
 */
@property (nonatomic, getter=isDD_AskNet) BOOL DD_AskNet;
@property (nonatomic, getter=isDD_AskNetFlag) BOOL DD_AskNetFlag;
/**
 上传网络请求
 */
@property (nonatomic, getter=isDD_UploadNet) BOOL DD_UploadNet;
@property (nonatomic, getter=isDD_UploadNetFlag) BOOL DD_UploadNetFlag;

/**
 更新数组开关
 */
@property (nonatomic, getter=isDD_Operation) BOOL DD_Operation;
/**
 更新数字开关的是否启用的标识
 */
@property (nonatomic, getter=isDD_OperationtFlag) BOOL DD_OperationtFlag;


/**
 数组操作添加的相关属性（存储属性）
 */
@property (nonatomic, assign) DDArrayOperation dd_operation;
@property (nonatomic, copy) NSArray<NSNumber *> *dd_indexS;
@property (nonatomic, copy) NSArray *dd_modelS;
@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation NSObject (DDNet)
#pragma clang diagnostic pop

#pragma mark - 便利的初始化方法
+ (instancetype)dd_NewAskNet:(id<DDNetResponder>)delegate {
    NSObject *obj = [[self alloc] init];
    [obj dd_add:delegate];
    obj.DD_AskNet = true;
    return obj;
}

#pragma mark - 数据驱动方法
- (void)dd_pull {
    if (self.isDD_AskNetFlag == false) {
        self.DD_AskNet = true;
    }
}

- (void)dd_pullSuAccept {
    self.DD_AskNetFlag = true;
}

- (void)dd_pullReAccept {
    self.DD_AskNetFlag = false;
}

- (void)dd_push {
    if (self.isDD_UploadNetFlag == false) {
        self.DD_UploadNet = true;
    }
}

- (void)dd_pushSuAccept {
    self.DD_UploadNetFlag = true;
}

- (void)dd_pushReAccept {
    self.DD_UploadNetFlag = false;
}

#pragma mark - 代理的增删改差
- (void)dd_add:(id<DDNetResponder>)delegate {
    if ([self dd_check:delegate] == false) {
        [self.DD_Delegates addObject:[DDNetObject newObject:delegate]];
    }
}

- (void)dd_remove:(id<DDNetResponder>)delegate {
    [self.DD_Delegates removeObject:[self dd_find:delegate]];
}

- (void)dd_removeAll {
    [self.DD_Delegates removeAllObjects];
}

- (void)dd_replace:(id<DDNetResponder>)before with:(id<DDNetResponder>)after {
    if ([self dd_check:before]) {
        NSUInteger index = [self.DD_Delegates indexOfObject:[self dd_find:before]];
        [self.DD_Delegates replaceObjectAtIndex:index withObject:[DDNetObject newObject:after]];
    } else {
        NSAssert(NO, @"before<DDNetResponder> not found");
    }
    
}

- (BOOL)dd_check:(id<DDNetResponder>)delegate {
    NSAssert(delegate, @"delegate can't be nil. if nil, return BOOL may be always true");
    
    for (DDNetObject *obj in self.DD_Delegates) {
        if ([obj.obj isEqual:delegate]) {
            return true;
        }
    }
    
    return false;
}

- (DDNetObject *)dd_find:(id<DDNetResponder>)delegate {
    NSAssert(delegate, @"delegate can't be nil. if nil, return DDNetObject may not match");
    
    for (DDNetObject *obj in self.DD_Delegates) {
        if ([obj.obj isEqual:delegate]) {
            return obj;
        }
    }
    return nil;
}

#pragma mark - runtime 添加的属性
- (void)setDD_AskNet:(BOOL)DD_AskNet {
    if (self.isDD_AskNet != DD_AskNet) {
        objc_setAssociatedObject(self, NSObjectDD_askNetKey, [NSNumber numberWithBool:DD_AskNet], OBJC_ASSOCIATION_ASSIGN);
        if (DD_AskNet == true) {
            self.DD_AskNet = false;
            //主动发起拉取数据网络请求
            for (DDNetObject *obj in self.DD_Delegates) {
                if (obj.isFlagAsk) {
                    [obj.obj ddAskNet:self response:^id _Nonnull(id  _Nonnull json) {
                        ///*1 提供默认的解析方案 短时间内无法先全面*/
                        //2.暴露出给一个统一解析的接口
                        //3.每个响应的model都可以重新定制解析方案
                        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
                        if ([self respondsToSelector:@selector(dd_defaultParse:)]) {
                            [self performSelector:@selector(dd_defaultParse:) withObject:json];
#pragma clang diagnostic pop
                        } else {
                            [DDNetParse dd_defaultParse:self json:json];
                        }
            
                        return self;
                    }];
                }
            }
        }
    }
}

- (BOOL)isDD_AskNet {
    id askNet = objc_getAssociatedObject(self, NSObjectDD_askNetKey);
    return [(NSNumber *)askNet boolValue];
}

- (void)setDD_AskNetFlag:(BOOL)DD_AskNetFlag {
    if (self.isDD_AskNetFlag != DD_AskNetFlag) {
        objc_setAssociatedObject(self, NSObjectDD_askNetFlagKey, [NSNumber numberWithBool:DD_AskNetFlag], OBJC_ASSOCIATION_ASSIGN);
    }
}

- (BOOL)isDD_AskNetFlag {
    id askNetFlag = objc_getAssociatedObject(self, NSObjectDD_askNetFlagKey);
    return [(NSNumber *)askNetFlag boolValue];
}

- (void)setDD_UploadNet:(BOOL)DD_UploadNet {
    if (self.isDD_UploadNet != DD_UploadNet) {
        objc_setAssociatedObject(self, NSObjectDD_askNetKey, [NSNumber numberWithBool:DD_UploadNet], OBJC_ASSOCIATION_ASSIGN);
        if (DD_UploadNet == true) {
            self.DD_UploadNet = false;
            // 主动发起上传数据网络请求
            for (DDNetObject *obj in self.DD_Delegates) {
                if (obj.isFlagUpload) {
                    [obj.obj ddUploadNet:self success:^{
                        // 上传成功
                        
                    } failure:^{
                        // 上传失败
                        
                    }];
                }
            }
        }
    }
    
}

- (BOOL)isDD_UploadNet {
    id uploadNet = objc_getAssociatedObject(self, NSObjectDD_askNetKey);
    return [(NSNumber *)uploadNet boolValue];
}

- (void)setDD_UploadNetFlag:(BOOL)DD_UploadNetFlag {
    if (self.isDD_UploadNetFlag != DD_UploadNetFlag) {
        objc_setAssociatedObject(self, NSObjectDD_uploadFlagNetKey, [NSNumber numberWithBool:DD_UploadNetFlag], OBJC_ASSOCIATION_ASSIGN);
    }
}

- (BOOL)isDD_UploadNetFlag {
    id uploadNetFlag = objc_getAssociatedObject(self, NSObjectDD_uploadFlagNetKey);
    return [(NSNumber *)uploadNetFlag boolValue];
}

- (void)setDD_Delegates:(NSMutableArray<DDNetObject *> *)DD_Delegates {
    objc_setAssociatedObject(self, NSObjectDD_DelegatesKey, DD_Delegates, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray<DDNetObject *> *)DD_Delegates {
    id delegates = objc_getAssociatedObject(self, NSObjectDD_DelegatesKey);
    if (delegates == nil) {
        delegates = [[NSMutableArray alloc] init];
        self.DD_Delegates = delegates;
    }
    return delegates;
}

#pragma mark - 数组相关操作
- (void)setDD_Operation:(BOOL)DD_Operation {
    if (self.isDD_Operation != DD_Operation) {
        objc_setAssociatedObject(self, NSObjectDD_OperationKey, [NSNumber numberWithBool:DD_Operation], OBJC_ASSOCIATION_ASSIGN);
        if (DD_Operation == true) {
            self.DD_Operation = false;
            for (DDNetObject *obj in self.DD_Delegates) {
                if (obj.isFlagArray) {
                    [obj.obj ddOperation:self.DD_Operation indexS:self.dd_indexS modelS:self.dd_modelS];
                }
            }
        }
    }

}

- (BOOL)isDD_Operation {
    id operation = objc_getAssociatedObject(self, NSObjectDD_OperationKey);
    return [(NSNumber *)operation boolValue];
}

- (void)setDD_OperationtFlag:(BOOL)DD_OperationtFlag {
    if (self.isDD_OperationtFlag != DD_OperationtFlag) {
        objc_setAssociatedObject(self, NSObjectDD_OperationtFlagKey, [NSNumber numberWithBool:DD_OperationtFlag], OBJC_ASSOCIATION_ASSIGN);
    }
}

- (BOOL)isDD_OperationtFlag {
    id flag = objc_getAssociatedObject(self, NSObjectDD_OperationtFlagKey);
    return [(NSNumber *)flag boolValue];
}


- (void)dd_updateArrayWithOperation:(DDArrayOperation)operation indexS:(NSArray<NSNumber *> *)indexS modelS:(NSArray *)modelS {
    if (self.isDD_OperationtFlag == false) {
        self.DD_Operation = true;
    }
    self.dd_operation = operation;
    self.dd_indexS = indexS;
    self.dd_modelS = modelS;
}

- (void)dd_updateArraySuAccept {
    self.DD_OperationtFlag = true;
}

- (void)dd_updateArrayReAccept {
    self.DD_OperationtFlag = false;
}

- (void)setDd_operation:(DDArrayOperation)dd_operation {
    if (self.dd_operation != dd_operation) {
        objc_setAssociatedObject(self, NSObjectdd_OperationKey, [NSNumber numberWithUnsignedInteger:dd_operation], OBJC_ASSOCIATION_ASSIGN);
    }
}

- (DDArrayOperation)dd_operation {
    id o = objc_getAssociatedObject(self, NSObjectdd_OperationKey);
    return [(NSNumber *)o unsignedIntegerValue];
}

- (void)setDd_indexS:(NSArray<NSNumber *> *)dd_indexS {
    objc_setAssociatedObject(self, NSObjectdd_indexSKey, dd_indexS, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSArray<NSNumber *> *)dd_indexS {
    return objc_getAssociatedObject(self, NSObjectdd_indexSKey);
}

- (void)setDd_modelS:(NSArray *)dd_modelS {
    objc_setAssociatedObject(self, NSObjectdd_modelSKey, dd_modelS, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSArray *)dd_modelS {
    return objc_getAssociatedObject(self, NSObjectdd_modelSKey);
}

@end

NS_ASSUME_NONNULL_END
