//
//  DDKVOCenter.h
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/16.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DDKVONotificationBlock)(id _Nullable observer, id object, NSDictionary<NSString *, id> *change);

@interface DDKVOCenter : NSObject

- (void)observed:(nonnull id)object keyPath:(nonnull NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(nonnull DDKVONotificationBlock)block;

- (void)removeobserved:(nonnull id)observed keyPath:(nonnull NSString *)keytPath;
@end
NS_ASSUME_NONNULL_END
