//
//  TwoViewController.m
//  DataDrivingDemo
//
//  Created by Mr.Pyy on 2017/6/15.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "TwoViewController.h"
#import "NSObject+DDNet.h"
#import "NSObject+DDView.h"

@interface TwoViewController () <DDNetResponder>

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.model dd_add:self];
}
- (IBAction)askNet:(id)sender {
    [self.model dd_pull];
}

- (void)ddAskNet:(id)model response:(id (^)(NSDictionary *))response {
    NSLog(@"two");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    NSLog(@"注销 %s", __FILE__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
