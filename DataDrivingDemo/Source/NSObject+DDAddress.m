//
//  NSObject+DDAddress.m
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/17.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "NSObject+DDAddress.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSObject (DDAddress)
- (NSString *)dd_getAddress {
    return [NSString stringWithFormat:@"%p", self];
}
@end

NS_ASSUME_NONNULL_END
