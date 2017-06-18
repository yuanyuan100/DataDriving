//
//  DDNetParse+def.m
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/18.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "DDNetParse+def.h"

#import <YYModel/YYModel.h>

@implementation DDNetParse (def)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
+ (void)dd_defaultParse:(id)model json:(id)json {
    NSLog(@"默认的解析方案");
    
    [model yy_modelSetWithJSON:json];
}
#pragma clang diagnostic pop
@end
