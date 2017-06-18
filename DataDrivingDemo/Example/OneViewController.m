//
//  OneViewController.m
//  DataDrivingDemo
//
//  Created by Mr.PYY on 17/6/18.
//  Copyright © 2017年 Mr.PYY. All rights reserved.
//

#import "OneViewController.h"

#import "TwoViewController.h"

#import "OneModel.h"


@interface OneViewController ()
@property (nonatomic, strong) OneModel *model;
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [OneModel new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [self getViewControllerName:indexPath.row];
    cell.detailTextLabel.text = [self getDetial:indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = [self getViewControllerName:indexPath.row];
    Class cls = NSClassFromString(className);
    if (NULL != cls) {
        UIViewController *vc = [[cls alloc] init];
        if ([vc respondsToSelector:@selector(setModel:)]) {
            [vc setValue:self.model forKey:@"model"];
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSString *)getViewControllerName:(NSUInteger)index {
    switch (index) {
        case 0:
            return @"TwoViewController";
        default:
        return @"";
    }
}

- (NSString *)getDetial:(NSUInteger)index {
    switch (index) {
        case 0:
            return @"DDNet";
        case 1:
            return @"DDView";
        default:
            return @"";
    }
}

@end
