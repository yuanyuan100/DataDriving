//
//  ThreeViewController.m
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/18.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "ThreeViewController.h"

#import "NSObject+DDView.h"

#import "OneModel.h"
#import "ThreeModel.h"

@interface ThreeViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) ThreeModel *threeModel;
@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.threeModel = [ThreeModel new];
    
    [self.model dd_bindObject:self.threeModel oPath:@"text" mPath:@"name" positive:^BOOL(NSDictionary<DDKeyValueDataFlowKey,id> * _Nonnull change) {
        
        return YES;
    } reverse:^BOOL(NSDictionary<DDKeyValueDataFlowKey,id> * _Nonnull change) {
        // threeModel发生的改变 model接受
        return YES;
    }];
    [self.threeModel dd_bindObject:self.label bothPath:@"text" positive:^BOOL(NSDictionary<DDKeyValueDataFlowKey,id> * _Nonnull change) {
        return NO;
    } reverse:nil];
    
    self.textField.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.threeModel.text = textField.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
     NSLog(@"注销 %s", __FILE__);
    [self.model dd_removeBind:self.threeModel oPath:@"text" mPath:@"name"];
    [self.threeModel dd_removeBind:self.label bothPath:@"text"];
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
