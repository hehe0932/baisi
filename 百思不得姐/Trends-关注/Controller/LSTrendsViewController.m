//
//  LSTrendsViewController.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/11.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSTrendsViewController.h"
#import "LSRecommendController.h"
#import "LSLoginRegisterController.h"
@interface LSTrendsViewController ()

@end

@implementation LSTrendsViewController

//label内文字换行XIB中按住option+回车即可
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    //导航栏左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(tagButtonAction)];
    self.view.backgroundColor = LSGlobaBg;
}

- (void)tagButtonAction {
    LSRecommendController *recommendVC = [[LSRecommendController alloc]init];
    [self.navigationController pushViewController:recommendVC animated:YES];
}
- (IBAction)loginRegister:(id)sender {
    LSLoginRegisterController *vc = [[LSLoginRegisterController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
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
