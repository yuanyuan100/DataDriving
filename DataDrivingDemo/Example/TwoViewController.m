//
//  TwoViewController.m
//  DataDrivingDemo
//
//  Created by Mr.Pyy on 2017/6/15.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "TwoViewController.h"
#import "ThreeViewController.h"

#import "NSObject+DDView.h"

#import "OneModel.h"

@interface TwoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *orangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *buleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.model dd_bindObject:self.label oPath:@"text" mPath:@"name"];
    
    [self.model dd_bindObject:self.orangeLabel oPath:@"text" mPath:@"name" positive:^BOOL(NSDictionary<DDKeyValueDataFlowKey,id> * _Nonnull change) {
        // 不接受model的改变
        return NO;
    } reverse:nil];
    [self.model dd_bindObject:self.buleLabel oPath:@"text" mPath:@"name" positive:^BOOL(NSDictionary<DDKeyValueDataFlowKey,id> * _Nonnull change) {
        
        return YES;
    } reverse:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ddtextfieldDidChanged:) name:UITextFieldTextDidChangeNotification object:self.textField];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
}

- (void)ddtextfieldDidChanged:(NSNotification *)noti {
    self.model.name = [noti.object text];
}

- (void)next {
    ThreeViewController *three = [ThreeViewController new];
    three.model = self.model;
    [self.navigationController pushViewController:three animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    NSLog(@"注销 %s", __FILE__);
    [self.model dd_removeBind:self.label oPath:@"text" mPath:@"name"];
    [self.model dd_removeBind:self.textField oPath:@"text" mPath:@"name"];
    [self.model dd_removeBind:self.orangeLabel oPath:@"text" mPath:@"name"];
    [self.model dd_removeBind:self.buleLabel oPath:@"text" mPath:@"name"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
