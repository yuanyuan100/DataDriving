//
//  DDNetResponder.h
//  DataDrivingDemo
//
//  Created by Mr.Pyy on 2017/6/15.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDArrayOperation) {
    DDArrayOperationAdd,
    DDArrayOperationRemove,
    DDArrayOperationReplace,
};

@protocol DDNetResponder <NSObject>

@required
/**
 拉取数据网络请求
 
 @param model 当前model
 @param response 数据响应的回调
 */
- (void)ddAskNet:(id)model response:(id(^)(id json))response;

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



/**
 针对model中包含数组的操作

 @param operation 操作类型
 @param indexS 被同一类型操作的Index 的数组集合, 二者任意传一类
 @param modelS 被同一类型操作的元素   的数组集合, 二者任意传一类
 */
- (void)ddOperation:(DDArrayOperation)operation indexS:(NSArray<NSNumber *> *)indexS modelS:(NSArray *)modelS;
@end

NS_ASSUME_NONNULL_END
