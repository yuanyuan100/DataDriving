//
//  ViewControllerModel.h
//  DataDrivingDemo
//
//  Created by Mr.Pyy on 2017/6/15.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewControllerModel : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSArray<ViewControllerModel *> *array;
@end
