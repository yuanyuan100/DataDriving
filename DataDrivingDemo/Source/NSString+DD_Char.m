//
//  NSString+DD_Char.m
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/16.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "NSString+DD_Char.h"

@implementation NSString (DD_Char)
- (const char *)dd_getChar {
    return [self UTF8String];
}
@end
