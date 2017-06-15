//
//  ViewController.m
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/14.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+DDNet.h"
#import "ViewControllerModel.h"

@interface ViewController () <DDNetResponder>
@property (nonatomic, strong) ViewControllerModel *model;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.model = [ViewControllerModel new];
    [self.model dd_add:self];
}

- (void)ddAskNet:(id)model response:(id (^)(NSDictionary *))response {
    NSLog(@"请求网络数据");
}

- (IBAction)askNet:(id)sender {
    self.model.DD_AskNet = YES;
    [self.model dd_remove:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
