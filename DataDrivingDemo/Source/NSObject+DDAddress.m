//
//  NSObject+DDAddress.m
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/17.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "NSObject+DDAddress.h"

@implementation NSObject (DDAddress)
- (NSString *)dd_getAddress {
    return [NSString stringWithFormat:@"%p", self];
}
@end
