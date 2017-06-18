//
//  NSObject+DDNet.h
//  DataDrivingDemo
//
//  Created by Mr.Pyy on 2017/6/15.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//
// 数据驱动网络请求

#import <Foundation/Foundation.h>

#import "DDNetResponder.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (DDNet)

/**
 快速初始化，初始化完毕后立即拉取网络请求

 @return 实例
 */
+ (instancetype)dd_NewAskNet:(id<DDNetResponder>)delegate;

///**************************************************************************///

/**
 拉取网络请求
 */
- (void)dd_pull;
/**
 暂停响应 拉取网络
 */
- (void)dd_pullSuAccept;
/**
 重启响应 拉取网络
 */
- (void)dd_pullReAccept;
///**************************************************************************///
/**
 上传网络请求
 */
- (void)dd_push;
/**
 暂停响应 上传网络请求
 */
- (void)dd_pushSuAccept;
/**
 重启响应 上传网络请求
 */
- (void)dd_pushReAccept;

///**************************************************************************///

// 数组操作
/**
 数组操作方式
 */
@property (nonatomic, readonly, assign) DDArrayOperation dd_operation;
/**
 被操作数组的index
 */
@property (nonatomic, readonly, copy) NSArray<NSNumber *> *dd_indexS;
/**
 被操作数组的元素
 */
@property (nonatomic, readonly, copy) NSArray *dd_modelS;
/**
 发起数组更新操作
 
 @param operation 数组操作方式
 @param indexS 被操作数组的index
 @param modelS 被操作数组的元素
 */
- (void)dd_updateArrayWithOperation:(DDArrayOperation)operation indexS:(NSArray<NSNumber *> *)indexS modelS:(NSArray *)modelS;
/**
 暂停响应 数组操作
 */
- (void)dd_updateArraySuAccept;
/**
 重启响应 数组操作
 */
- (void)dd_updateArrayReAccept;

///**************************************************************************///
/**
 添加 实现 DDNetResponder协议 的对象

 @param delegate 实现 DDNetResponder协议 的对象
 */
- (void)dd_add:(id<DDNetResponder>)delegate;
/**
 移除 实现 DDNetResponder协议 的对象

 @param delegate 实现 DDNetResponder协议 的对象
 */
- (void)dd_remove:(id<DDNetResponder>)delegate;
/**
 移除所有实现 DDNetResponder协议 的对象
 */
- (void)dd_removeAll;
/**
 替换 实现 DDNetResponder协议 的对象

 @param before 被替换的协议对象
 @param after 将要add的协议对象
 */
- (void)dd_replace:(id<DDNetResponder>)before with:(id<DDNetResponder>)after;
/**
 检查 实现 DDNetResponder协议 的对象 是否存在

 @param delegate 实现 DDNetResponder协议 的对象
 @return YES:存在 NO:不存在
 */
- (BOOL)dd_check:(id<DDNetResponder>)delegate;

///**************************************************************************///
/**
 如果子类实现了该方法，则将替代默认的json解析方案

 @param json json
 */
- (void)dd_customParse:(id)json;

@end

NS_ASSUME_NONNULL_END
