//
//  AppDelegate.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/10.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "AppDelegate.h"
#import "LSRootController.h"
#import "LSPushGuideView.h"
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor grayColor];
    
    LSRootController *rootVC = [[LSRootController alloc]init];
    rootVC.delegate = self;
    self.window.rootViewController = rootVC;
    //key:iOS6.0以前除了主窗口,其他的窗口是不能呼出键盘的(不能成为第一响应者)
    //Visible:显示
    [self.window makeKeyAndVisible];
    
    //显示推送引导
    [LSPushGuideView show];
    return YES;
}
#pragma mark - tabbarcontrollerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //发一个通知
    [LSNoteCenter postNotificationName:LSTabBarDidSelectNotification object:nil userInfo:nil];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
