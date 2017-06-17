//
//  DDNetResponder.h
//  DataDrivingDemo
//
//  Created by Mr.Pyy on 2017/6/15.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DDNetResponder <NSObject>

@required
/**
 拉取数据网络请求
 
 @param model 当前model
 @param response 数据响应的回调
 */
- (void)ddAskNet:(id)model response:(id(^)(NSDictionary *d))response;

@optional
/**
 发起上传数据网络请求
 
 @param model 当前model
 @param success 上传数据成功的回调
 @param failure 上传数据失败的回调
 */
- (void)ddUploadNet:(id)model
            success:(void(^)())success
            failure:(void(^)())failure;

@end

NS_ASSUME_NONNULL_END
