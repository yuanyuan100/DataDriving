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
 拉取网络请求
 */
@property (nonatomic, getter=isDD_AskNet) BOOL DD_AskNet;

/**
 上传网络请求
 */
@property (nonatomic, getter=isDD_UploadNet) BOOL DD_UploadNet;

- (void)dd_add:(id<DDNetResponder>)delegate;
- (void)dd_remove:(id<DDNetResponder>)delegate;
- (void)dd_removeAll;
- (void)dd_replace:(id<DDNetResponder>)before with:(id<DDNetResponder>)after;
- (BOOL)dd_check:(id<DDNetResponder>)delegate;

@end
