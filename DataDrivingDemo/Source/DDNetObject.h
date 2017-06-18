//
//  DDNetObject.h
//  DataDrivingDemo
//
//  Created by Mr.Pyy on 2017/6/15.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDNetResponder.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDNetObject : NSObject

/**
 实现了DDNetResponder协议的代理类
 */
@property (nonatomic, weak) id<DDNetResponder> obj;

/**
 是否 实现了 DDNetResponder 发起数据网络请求协议 的标记
 */
@property (nonatomic, getter=isFlagAsk) BOOL flagAsk;

/**
 是否 实现了 DDNetResponder 发起上传网络请求协议
 */
@property (nonatomic, getter=isFlagUpload) BOOL flagUpload;

/**
 是否 实现了 DDNetResponder 更新数组的操作
 */
@property (nonatomic, getter=isFlagArray) BOOL flagArray;

/**
 便利的初始化方法，不是必须的初始化方法

 @param delegate 实现了DDNetResponder的对象
 @return 实例对象
 */
+ (instancetype)newObject:(id<DDNetResponder>)delegate;
@end

NS_ASSUME_NONNULL_END
