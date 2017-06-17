//
//  NSObject+DDAddress.h
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/17.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (DDAddress)

/**
 获取对象的字符串地址

 @return 对象的内存地址
 */
- (NSString *)dd_getAddress;
@end

NS_ASSUME_NONNULL_END
