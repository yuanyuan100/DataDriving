//
//  DDNetObject.h
//  DataDrivingDemo
//
//  Created by Mr.Pyy on 2017/6/15.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDNetResponder.h"

@interface DDNetObject : NSObject

/**
 实现了DDNetResponder协议的代理类
 */
@property (nonatomic, weak) id<DDNetResponder> obj;

/**
 是否 实现了 DDNetResponder 的标记
 */
@property (nonatomic, getter=isFlagAsk) BOOL flagAsk;
@property (nonatomic, getter=isFlagUpload) BOOL flagUpload;

+ (instancetype)newObject:(id<DDNetResponder>)delegate;
@end
