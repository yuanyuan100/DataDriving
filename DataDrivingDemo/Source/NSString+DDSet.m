//
//  NSString+DDSet.m
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/17.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "NSString+DDSet.h"

@implementation NSString (DDSet)
- (NSString *)dd_appendingSet {
    NSString *up = self.capitalizedString;
    return [NSString stringWithFormat:@"set%@:", up];
}
@end
