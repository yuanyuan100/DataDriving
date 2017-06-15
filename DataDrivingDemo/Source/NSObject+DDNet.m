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
static void *NSObjectDD_uploadNetKey = &NSObjectDD_uploadNetKey;
static void *NSObjectDD_DelegatesKey = &NSObjectDD_DelegatesKey;

@interface NSObject ()
@property (nonatomic ,strong) NSMutableArray<DDNetObject *> *DD_Delegates;
@end

@implementation NSObject (DDNet)
@dynamic DD_AskNet;
@dynamic DD_UploadNet;

- (void)dd_add:(id<DDNetResponder>)delegate {
    [self.DD_Delegates addObject:[DDNetObject newObject:delegate]];
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
    
    return NO;
}

- (DDNetObject *)dd_find:(id<DDNetResponder>)delegate {
    for (DDNetObject *obj in self.DD_Delegates) {
        if ([obj.obj isEqual:delegate]) {
            return obj;
        }
    }
    return nil;
}


- (void)setDD_AskNet:(BOOL)DD_AskNet {
    if (self.isDD_AskNet != DD_AskNet) {
        objc_setAssociatedObject(self, NSObjectDD_askNetKey, [NSNumber numberWithBool:DD_AskNet], OBJC_ASSOCIATION_ASSIGN);
        if (DD_AskNet == true) {
            self.DD_AskNet = NO;
            //主动发起拉取数据网络请求
            for (DDNetObject *obj in self.DD_Delegates) {
                if (obj.isFlagAsk) {
                    [obj.obj ddAskNet:self response:^id(NSDictionary *d) {
                        // 解析字典，在我们的APP内，解析Data:{}
                        
                        
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

- (void)setDD_UploadNet:(BOOL)DD_UploadNet {
    if (self.isDD_UploadNet != DD_UploadNet) {
        objc_setAssociatedObject(self, NSObjectDD_askNetKey, [NSNumber numberWithBool:DD_UploadNet], OBJC_ASSOCIATION_ASSIGN);
        if (DD_UploadNet == true) {
            self.DD_UploadNet = NO;
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

- (void)setDD_Delegates:(NSMutableArray<DDNetObject *> *)DD_Delegates {
    objc_setAssociatedObject(self, NSObjectDD_DelegatesKey, DD_Delegates, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSMutableArray<DDNetObject *> *)DD_Delegates {
    id delegates = objc_getAssociatedObject(self, NSObjectDD_DelegatesKey);
    if (delegates == nil) {
        delegates = [[NSMutableArray alloc] init];
        self.DD_Delegates = delegates;
    }
    return delegates;
}

@end

NS_ASSUME_NONNULL_END
