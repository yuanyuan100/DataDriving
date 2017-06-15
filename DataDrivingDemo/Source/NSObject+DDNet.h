//
//  NSObject+DDNet.h
//  DataDrivingDemo
//
//  Created by Mr.Pyy on 2017/6/15.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDNetResponder.h"

@interface NSObject (DDNet)

/**
 快速初始化，初始化完毕后立即拉取网络请求

 @return 实例
 */
+ (instancetype)dd_NewAskNet:(id<DDNetResponder>)delegate;

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
/**
 上传网络请求
 */
- (void)dd_push;
- (void)dd_pushSuAccept;
- (void)dd_pushReAccept;

- (void)dd_add:(id<DDNetResponder>)delegate;
- (void)dd_remove:(id<DDNetResponder>)delegate;
- (void)dd_removeAll;
- (void)dd_replace:(id<DDNetResponder>)before with:(id<DDNetResponder>)after;
- (BOOL)dd_check:(id<DDNetResponder>)delegate;

@end
