//
//  NSString+DDSet.m
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/17.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "NSString+DDSet.h"

#import "NSObject+DDAddress.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSString (DDSet)

- (SEL)dd_propertySetMethod {
    NSString *methodStr = [NSString stringWithFormat:@"set%@:", [self capitalizedString]];
    return NSSelectorFromString(methodStr);
}

- (SEL)dd_propertyGetMethod {
    return NSSelectorFromString(self);
}

- (NSString *)dd_addDiff:(DDSetDiff)diff {
    switch (diff) {
        case DDSetDiffM:
            return [@"DDM" stringByAppendingString:self];
        case DDSetDiffO:
            return [@"DDO" stringByAppendingString:self];
        default:
            NSAssert(NO, @"必须满足枚举");
            return self;
    }
}

- (NSString *)dd_instanceVariable {
    return [@"_" stringByAppendingString:self];
}

- (NSString *)dd_addressObject:(NSString *)object changed:(NSString *)changed {
    return [NSString stringWithFormat:@"%@%@%@", self, object.dd_getAddress, changed.dd_getAddress];
}

@end

NS_ASSUME_NONNULL_END
