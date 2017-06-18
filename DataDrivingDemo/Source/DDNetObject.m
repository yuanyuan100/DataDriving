//
//  DDNetObject.m
//  DataDrivingDemo
//
//  Created by Mr.Pyy on 2017/6/15.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "DDNetObject.h"

NS_ASSUME_NONNULL_BEGIN

@implementation DDNetObject
+ (instancetype)newObject:(id<DDNetResponder>)delegate {
    NSAssert(delegate, @"delegate can't be nil");
    
    DDNetObject *obj = [DDNetObject new];
    if ([delegate respondsToSelector:@selector(ddAskNet:response:)]) {
        obj.flagAsk = true;
    }
    if ([delegate respondsToSelector:@selector(ddUploadNet:success:failure:)]) {
        obj.flagUpload = true;
    }
    if ([delegate respondsToSelector:@selector(ddOperation:indexS:modelS:)]) {
        obj.flagArray = true;
    }
    
    obj.obj = delegate;
    
    return obj;
}
@end

NS_ASSUME_NONNULL_END
