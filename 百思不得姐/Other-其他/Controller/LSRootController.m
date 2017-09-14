//
//  LSRootController.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/10.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSRootController.h"
#import "UIImage+LSExtension.h"
#import "LSTrendsViewController.h"
#import "LSMeViewController.h"
#import "LSEssenceViewController.h"
#import "LSNewViewController.h"
#import "LSTabBar.h"
#import "LSNavigationController.h"
@interface LSRootController ()

@end

@implementation LSRootController
+ (void)initialize{
    //主题设置
    UITabBarItem *itemAppearance = [UITabBarItem appearance];
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    [itemAppearance setTitleTextAttributes:dic forState:UIControlStateSelected];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加所有的子控制器
    [self addChildVCs];
}

/**
 添加所有的子控制器
 */
- (void)addChildVCs {
    //精华
    [self setupChildViewController:[[LSEssenceViewController alloc]init] title:@"精华" imageName:@"tabBar_essence_icon"];
    //新帖
    [self setupChildViewController:[[LSNewViewController alloc]init] title:@"新帖" imageName:@"tabBar_new_icon"];
    //关注
    [self setupChildViewController:[[LSTrendsViewController alloc]init] title:@"关注" imageName:@"tabBar_friendTrends_icon"];
    //我
    [self setupChildViewController:[[LSMeViewController alloc]init] title:@"我" imageName:@"tabBar_me_icon"];
    
   //更换tabbar
    //self.tabBar = [[LSTabBar alloc]init];//不可以
    [self setValue:[[LSTabBar alloc]init] forKeyPath:@"TabBar"];
    
    
}
/**
 创建子控制器的方法
 */
- (void)setupChildViewController:(UIViewController *)vc title:(NSString*)title imageName:(NSString *)imageName{
    //精华
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    NSString *selectImageName = [imageName stringByAppendingString:@"_click"];
    vc.tabBarItem.selectedImage = [UIImage originalImageName:selectImageName];
    
//    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    //包装一个导航控制器
    LSNavigationController *nv = [[LSNavigationController alloc]initWithRootViewController:vc];
    
    
    [self addChildViewController:nv];
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
