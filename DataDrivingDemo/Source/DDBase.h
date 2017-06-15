//
//  DDBase.h
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/14.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DDBase <NSObject>

@end

//****************************************************************************//

@interface DDBase : NSObject

@end

//****************************************************************************//

@protocol DDRefreshUI <NSObject>

- (void)ddRefresh:(__kindof DDBase *)model;

@end
