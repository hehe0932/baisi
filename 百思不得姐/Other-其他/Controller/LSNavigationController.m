//
//  LSNavigationController.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/12.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSNavigationController.h"

@interface LSNavigationController ()

@end

@implementation LSNavigationController

/**
 当第一次使用这个类的时候调用
 */
+(void)initialize{
    //    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //normal状态
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor blackColor];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    //disable状态
    NSMutableDictionary *disabelAttributes = [NSMutableDictionary dictionary];
    disabelAttributes[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disabelAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:disabelAttributes forState:UIControlStateDisabled];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count>0) {//如果push进来的不是第一个
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [button setTitle:@"返回" forState:(UIControlStateNormal)];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:(UIControlStateNormal)];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:(UIControlStateHighlighted)];
        button.size = CGSizeMake(100, 30);
        //让按钮内部的所有左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor redColor] forState:(UIControlStateHighlighted)];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        //隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        [button addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    }
    //这句super的push要放在最后,让上面的viewcontroller覆盖掉leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}
- (void)back{
    [self popViewControllerAnimated:YES];
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
