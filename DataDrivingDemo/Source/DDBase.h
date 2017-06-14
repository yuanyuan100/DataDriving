//
//  DDBase.h
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/14.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DDBase <NSObject>

- (void)add:(id<DDNetResponder>)delegate;
- (void)remove:(id<DDNetResponder>)delegate;
- (void)change:(id<DDNetResponder>)before to:(id<DDNetResponder>)after;
- (BOOL)check:(id<DDNetResponder>)delegate;

@end

//****************************************************************************//

@interface DDBase : NSObject

@end

//****************************************************************************//

@protocol DDRefreshUI <NSObject>

- (void)ddRefresh:(__kindof DDBase *)model;

@end
