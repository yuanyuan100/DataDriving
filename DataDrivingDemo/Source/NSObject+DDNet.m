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


NS_ASSUME_NONNULL_BEGIN

static void *NSObjectDD_askNetKey = &NSObjectDD_askNetKey;
static void *NSObjectDD_askNetFlagKey = &NSObjectDD_askNetFlagKey;
static void *NSObjectDD_uploadNetKey = &NSObjectDD_uploadNetKey;
static void *NSObjectDD_uploadFlagNetKey = &NSObjectDD_uploadFlagNetKey;
static void *NSObjectDD_DelegatesKey = &NSObjectDD_DelegatesKey;

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
@end

@implementation NSObject (DDNet)

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
    NSUInteger index = [self.DD_Delegates indexOfObject:[self dd_find:before]];
    [self.DD_Delegates replaceObjectAtIndex:index withObject:[DDNetObject newObject:after]];
}

- (BOOL)dd_check:(id<DDNetResponder>)delegate {
    for (DDNetObject *obj in self.DD_Delegates) {
        if ([obj.obj isEqual:delegate]) {
            return true;
        }
    }
    
    return false;
}

- (DDNetObject *)dd_find:(id<DDNetResponder>)delegate {
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
                    [obj.obj ddAskNet:self response:^id(NSDictionary *d) {
                        // 解析字典，在我们的APP内，解析Data:{}
                        //1 提供默认的解析方案
                        //2.暴露出给一个统一解析的接口
                        //3.每个响应的model都可以重新定制解析方案
                        
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

@end

NS_ASSUME_NONNULL_END
