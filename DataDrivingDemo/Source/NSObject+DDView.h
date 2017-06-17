//
//  NSObject+DDView.h
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/15.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//
// 数据驱动UI层， 控件（viewModel）与数据绑定

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef DD_EXPORT
#define DD_EXPORT extern
#endif

typedef NSString * DDKeyValueDataFlowKey NS_STRING_ENUM;

DD_EXPORT DDKeyValueDataFlowKey const DDKeyValueDataWillFlowKey;
DD_EXPORT DDKeyValueDataFlowKey const DDKeyValueDataDidFlowKey;
DD_EXPORT DDKeyValueDataFlowKey const DDKeyValueDataFlowNewKey;
DD_EXPORT DDKeyValueDataFlowKey const DDKeyValueDataFlowOldKey;


@interface NSObject (DDView)

/**
 将object 数据对象 与 该类的实例path属性双向绑定， 双向属性名称一致
 
 默认绑定时 不给被绑定对象赋值 default showNow = NO

 @param object 被绑定的对象
 @param path 共同的属性名称，属性类型必须一致
 */
- (void)dd_bindObject:(nonnull id)object bothPath:(nonnull NSString *)path;

/**
  将object 数据对象 与 该类的实例path属性双向绑定， 双向属性名称一致

 @param object 被绑定的对象
 @param path 共同的属性名称，属性类型必须一致
 @param showNow if YES, set method be called rightNow, or set method will not be called
 */
- (void)dd_bindObject:(nonnull id)object bothPath:(nonnull NSString *)path showNow:(BOOL)showNow;

/**
 将object 数据对象 与 该类的实例path属性双向绑定，双向属性名称不一致
 
  默认绑定时 不给被绑定对象赋值 default showNow = NO

 @param object 被绑定的对象
 @param oPath 被绑定对象的属性名称
 @param mPath 主动绑定对象的属性名称
 */
- (void)dd_bindObject:(id)object oPath:(NSString *)oPath mPath:(NSString *)mPath;

/**
 将object 数据对象 与 该类的实例path属性双向绑定，双向属性名称不一致

 @param object 被绑定的对象
 @param oPath 被绑定对象的属性名称
 @param mPath 主动绑定对象的属性名称
 @param showNow if YES, set method be called rightNow, or set method will not be called
 */
- (void)dd_bindObject:(id)object oPath:(NSString *)oPath mPath:(NSString *)mPath showNow:(BOOL)showNow;

/**
 将object 数据对象 与 该类的实例path属性双向绑定， 双向属性名称一致
 
 默认绑定时 不给被绑定对象赋值 default showNow = NO

 @param object 被绑定的对象
 @param path 共同的属性名称，属性类型必须一致
 @param positive 数据从model流向viewModel, if return NO 则正向绑定失效， default YES
 @param reverse 数据从viewModel流向model, if return NO 则反向绑定失效, default YES
 */
- (void)dd_bindObject:(nonnull id)object bothPath:(nonnull NSString *)path positive:(nullable BOOL(^)(NSDictionary<DDKeyValueDataFlowKey, id> *change))positive reverse:(nullable BOOL(^)(NSDictionary<DDKeyValueDataFlowKey, id> *change))reverse;

/**
 将object 数据对象 与 该类的实例path属性双向绑定， 双向属性名称一致

 @param object 被绑定的对象
 @param path 共同的属性名称，属性类型必须一致
 @param positive 数据从model流向viewModel, if return NO 则正向绑定失效， default YES
 @param reverse 数据从viewModel流向model, if return NO 则反向绑定失效, default YES
 @param showNow if YES, set method be called rightNow, or set method will not be called
 */
- (void)dd_bindObject:(nonnull id)object bothPath:(nonnull NSString *)path positive:(nullable BOOL(^)(NSDictionary<DDKeyValueDataFlowKey, id> *change))positive reverse:(nullable BOOL(^)(NSDictionary<DDKeyValueDataFlowKey, id> *change))reverse showNow:(BOOL)showNow;

/**
 将object 数据对象 与 该类的实例path属性双向绑定，双向属性名称不一致

 @param object 被绑定的对象
 @param oPath 被绑定对象的属性名称
 @param mPath 主动绑定对象的属性名称
 @param positive 数据从model流向viewModel, if return NO 则正向绑定失效， default YES
 @param reverse 数据从viewModel流向model, if return NO 则反向绑定失效, default YES
 */
- (void)dd_bindObject:(id)object oPath:(NSString *)oPath mPath:(NSString *)mPath positive:(nullable BOOL(^)(NSDictionary<DDKeyValueDataFlowKey, id> *change))positive reverse:(nullable BOOL(^)(NSDictionary<DDKeyValueDataFlowKey, id> *change))reverse;

/**
 将object 数据对象 与 该类的实例path属性双向绑定，双向属性名称不一致
 
 默认绑定时 不给被绑定对象赋值 default showNow = NO

 @param object 被绑定的对象
 @param oPath 被绑定对象的属性名称
 @param mPath 主动绑定对象的属性名称
 @param positive 数据从model流向viewModel, if return NO 则正向绑定失效， default YES
 @param reverse 数据从viewModel流向model, if return NO 则反向绑定失效, default YES
 @param showNow if YES, set method be called rightNow, or set method will not be called
 */
- (void)dd_bindObject:(id)object oPath:(NSString *)oPath mPath:(NSString *)mPath positive:(nullable BOOL(^)(NSDictionary<DDKeyValueDataFlowKey, id> *change))positive reverse:(nullable BOOL(^)(NSDictionary<DDKeyValueDataFlowKey, id> *change))reverse showNow:(BOOL)showNow;

/**
 移除被绑定对象 object

 @param object 移除被绑定对象
 @param path 被绑定对象的属性名称
 */
- (void)dd_removeBind:(id)object bothPath:(NSString *)path;

/**
 移除双向绑定对象 object

 @param object 被绑定对象
 @param oPath 移除被绑定对象
 @param mPath 移除主动绑定对象
 */
- (void)dd_removeBind:(id)object oPath:(NSString *)oPath mPath:(NSString *)mPath;
@end

NS_ASSUME_NONNULL_END
