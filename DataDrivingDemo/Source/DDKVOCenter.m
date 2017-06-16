//
//  DDKVOCenter.m
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/16.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "DDKVOCenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDKVOCenter ()
@property (nonatomic, copy) DDKVONotificationBlock block;
@end

@implementation DDKVOCenter

- (void)observed:(nonnull id)object keyPath:(nonnull NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(nonnull DDKVONotificationBlock)block {
    NSAssert(object, @"被观察对象为空");
    NSAssert(keyPath.length != 0, @"被观察对象属性长度为0");
    NSAssert(block != NULL, @"block is NULL");
    
    if (nil == object || 0 == keyPath.length || NULL == block) {
        return;
    }

    if (block) {
        self.block = block;
    }
 
    [object addObserver:self forKeyPath:keyPath options:options context:nil];
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey,id> *)change context:(nullable void *)context {
//    [object removeObserver:self forKeyPath:keyPath];
    if (self.block) {
        self.block(self, object, change);
    }
}

- (void)removeobserved:(nonnull id)observed keyPath:(nonnull NSString *)keytPath {
    [observed removeObserver:self forKeyPath:keytPath];
}
@end

NS_ASSUME_NONNULL_END
