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
#import "TwoViewController.h"
#import "NSObject+DDView.h"

#import "NSObject+DDView.h"

@interface ViewController () <DDNetResponder>
@property (nonatomic, strong) ViewControllerModel *model;
@property (weak, nonatomic) IBOutlet UILabel *labelT;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.model = [ViewControllerModel dd_NewAskNet:self];
    self.model = [ViewControllerModel new];
    self.model.text = @"pyy";
    [self.model dd_bindObject:self.labelT bothPath:@"text" positive:nil reverse:nil showNow:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.model dd_add:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.model dd_remove:self];
}

- (void)ddAskNet:(id)model response:(id (^)(id))response {
    
    response(@{@"text": @"宝宝"});
    
    NSLog(@"请求网络数据");
}

- (IBAction)askNet:(id)sender {
    [self.model dd_pull];
}
- (IBAction)nextVC:(id)sender {
    TwoViewController *two = [TwoViewController new];
    two.model = self.model;
    [self.navigationController pushViewController:two animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
