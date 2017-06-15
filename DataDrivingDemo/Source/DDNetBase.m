//
//  DDNetBase.m
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/14.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "DDNetBase.h"
#import "NSObject+DDNet.h"


@implementation DDNetBase
@synthesize askNet = _askNet;
@synthesize uploadNet = _uploadNet;


#pragma mark ----------- 实现DDNet协议
- (void)setAskNet:(BOOL)askNet {
    if (_askNet != askNet) {
        _askNet = askNet;
        if (_askNet == true) {
            // 主动发拉取数据网络请求
            
        }
    }
}

- (BOOL)isAskNet {
    return _askNet;
}

- (void)setUploadNet:(BOOL)uploadNet {
    if (_uploadNet != uploadNet) {
        _uploadNet = uploadNet;
        if (_uploadNet == true) {
            // 主动发起上传数据网络请求
        }
    }
}

- (BOOL)isUploadNet {
    return _uploadNet;
}

@end
