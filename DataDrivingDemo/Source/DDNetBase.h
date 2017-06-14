//
//  DDNetBase.h
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/14.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "DDBase.h"

@protocol DDNetResponder;

/**
 如果实现了DDNet协议，则可以数据驱动网络相关请求
 */
@protocol DDNet <NSObject>

/**
 拉取网络请求
 */
@property (nonatomic, getter=isAskNet) BOOL askNet;

/**
 上传网络请求
 */
@property (nonatomic, getter=isUploadNet) BOOL uploadNet;

@end
//****************************************************************************//

@interface DDNetBase : DDBase <DDNet>

@end

//****************************************************************************//

@protocol DDNetResponder <NSObject>

@required
/**
 拉取数据网络请求
 
 @param model 当前model
 @param response 数据响应的回调
 */
- (void)ddAskNet:(__kindof DDNetBase *)model response:(id(^)())response;

@optional
/**
 发起上传数据网络请求

 @param model 当前model
 @param success 上传数据成功的回调
 @param failure 上传数据失败的回调
 */
- (void)ddUploadNet:(__kindof DDNetBase *)model
            success:(void(^)())success
            failure:(void(^)())failure;

@end
