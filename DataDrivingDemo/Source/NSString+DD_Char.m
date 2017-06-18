//
//  NSString+DD_Char.m
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/16.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "NSString+DD_Char.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSString (DD_Char)
- (const char *)dd_getChar {
    return [self UTF8String];
}

+ (NSString *)dd_getString:(const char *)cStr {
    return [NSString stringWithCString:cStr encoding:NSUTF8StringEncoding];
}
@end

NS_ASSUME_NONNULL_END
