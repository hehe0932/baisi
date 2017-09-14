//
//  LSLoginRegisterController.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/16.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSLoginRegisterController.h"

@interface LSLoginRegisterController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
//登录框距离控制器左边的间距
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation LSLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    NSMutableAttributedString *placeholer = [[NSMutableAttributedString alloc]initWithString:@"手机号" attributes:attrs];
//    self.phoneNumField.attributedPlaceholder = placeholer;
    //另一种方法
//    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:@"手机号"];
//    [placeholder setAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 1)];
//    self.phoneNumField.attributedPlaceholder = placeholder;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)showLoginOrRegister:(UIButton *)button {
    //退出键盘
    [self.view endEditing:YES];
    if (self.loginViewLeftMargin.constant==0) {//显示注册页面
        self.loginViewLeftMargin.constant = -self.view.width;
        [button setTitle:@"已有账号?" forState:(UIControlStateNormal)];
    }else{//显示登录页面
        self.loginViewLeftMargin.constant = 0;
        [button setTitle:@"注册账号" forState:(UIControlStateNormal)];
    }
    [UIView animateWithDuration:.25 animations:^{
        [self.view layoutIfNeeded];
    }];
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
