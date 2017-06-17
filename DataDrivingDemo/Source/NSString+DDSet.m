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

- (NSString *)dd_addDiff:(DDSetDiff)diff {
    switch (diff) {
        case DDSetDiffM:
            return [@"M" stringByAppendingString:self];
        case DDSetDiffO:
            return [@"O" stringByAppendingString:self];
        default:
            NSAssert(NO, @"必须满足枚举");
            return self;
    }
}

- (NSString *)dd_instanceVariable {
    return [@"_" stringByAppendingString:self];
}
@end
