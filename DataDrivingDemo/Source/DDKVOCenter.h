//
//  DDKVOCenter.h
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/16.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//
// 管理KVO

#import <Foundation/Foundation.h>

#import "NSString+DDSet.h"

NS_ASSUME_NONNULL_BEGIN

/**
 KVO 回调

 @param observer 观察者
 @param object 被观察者
 @param change 数据变化
 */
typedef void(^DDKVONotificationBlock)(id _Nullable observer, id object, NSDictionary<NSString *, id> *change);

@interface DDKVOCenter : NSObject


/**
 添加被观察者

 @param object 被观察者
 @param keyPath 被观察者属性名称
 @param options 观察内容
 @param block KVO 回调
 */
- (void)observed:(nonnull id)object keyPath:(nonnull NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(nonnull DDKVONotificationBlock)block;


/**
 移除 KVO

 @param observed 被观察者
 @param keytPath 悲观者属性名称
 */
- (void)removeobserved:(nonnull id)observed keyPath:(nonnull NSString *)keytPath;
@end
NS_ASSUME_NONNULL_END
