//
//  NSString+DD_Char.h
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/16.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (DD_Char)
@property (readonly) const char * dd_getChar;
@end

NS_ASSUME_NONNULL_END
