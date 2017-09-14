//
//  LSMeViewController.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/11.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSMeViewController.h"

@interface LSMeViewController ()

@end

@implementation LSMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    //导航栏右边按钮
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingButtonAction)],[UIBarButtonItem itemWithImage:@"mine-sun-icon" highImage:@"mine-sun-icon-click" target:self action:@selector(nightButtonAction)]];
    self.view.backgroundColor = LSGlobaBg;
}

- (void)settingButtonAction {
    
}

- (void)nightButtonAction {
    
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
