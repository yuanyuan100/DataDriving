//
//  DDNetParse.h
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/18.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDNetParse : NSObject

/**
 请使用类别重写该方法，以提供默认的json转model

 @param model model对象
 @param json json
 */
+ (void)dd_defaultParse:(id)model json:(id)json;
@end

NS_ASSUME_NONNULL_END
