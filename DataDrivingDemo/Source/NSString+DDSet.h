//
//  NSString+DDSet.h
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/17.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDSetDiff) {
    DDSetDiffO,
    DDSetDiffM,
};

@interface NSString (DDSet)

/**
 拼接为属性的set方法

 @return set方法
 */
- (SEL)dd_propertySetMethod;

/**
 拼接为属性的get方法
 
 @return get方法
 */
- (SEL)dd_propertyGetMethod;

/**
  将不同的大写字母拼接在字符串之前

 @param diff 可选的大写字母
 @return 字符串
 */
- (NSString *)dd_addDiff:(DDSetDiff)diff;

/**
 封装为实例成员变量的样子 _variable

 @return 成员变量的样子
 */
- (NSString *)dd_instanceVariable;


/**
 objctAddress + modelAddress + path

 @param object 被观察对象的地址字符串
 @param changed 被改变对象对象的地址字符串
 @return 拼接
 */
- (NSString *)dd_addressObject:(id)object changed:(id)changed;
@end

NS_ASSUME_NONNULL_END
