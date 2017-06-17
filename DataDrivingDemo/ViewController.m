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
    [self.model dd_add:self];
    [self.model dd_bindObject:self.labelT bothPath:@"text" positive:nil reverse:nil];
}

- (void)ddAskNet:(id)model response:(id (^)(NSDictionary *))response {
    NSLog(@"请求网络数据");
    self.model.text = @"pyy";
    
    NSLog(@"设置model == %@", self.model.text);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.labelT.text = @"来自Label 的改变";
        [self.model dd_removeBind:self.labelT bothPath:@"text"];
        self.model = nil;
        NSLog(@"**设置model == %@", self.model.text);
    });
    
    
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
