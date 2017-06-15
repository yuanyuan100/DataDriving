//
//  DDNetBase.h
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/14.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "DDBase.h"

@protocol DDNetResponder;

/**
 如果实现了DDNet协议，则可以数据驱动网络相关请求
 */
@protocol DDNet <NSObject>

/**
 拉取网络请求
 */
@property (nonatomic, getter=isAskNet) BOOL askNet;

/**
 上传网络请求
 */
@property (nonatomic, getter=isUploadNet) BOOL uploadNet;



@end
//****************************************************************************//

@interface DDNetBase : DDBase <DDNet>

@end


