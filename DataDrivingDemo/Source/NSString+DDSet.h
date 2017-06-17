//
//  NSString+DDSet.h
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/17.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DDSetDiff) {
    DDSetDiffO,
    DDSetDiffM,
};

@interface NSString (DDSet)

/**
 将属性名称转为set方法

 @return set方法名
 */
- (NSString *)dd_appendingSet;


- (NSString *)dd_addDiff:(DDSetDiff)diff;


/**
 封装为实例成员变量的样子 _variable

 @return 成员变量的样子
 */
- (NSString *)dd_instanceVariable;
@end
