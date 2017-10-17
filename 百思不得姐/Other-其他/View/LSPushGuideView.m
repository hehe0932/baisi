//
//  LSPushGuideView.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/17.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSPushGuideView.h"

@implementation LSPushGuideView


- (IBAction)close:(id)sender {
    [self removeFromSuperview];
}
+ (void)show{
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sanboxversion = [[NSUserDefaults standardUserDefaults]stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxversion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        LSPushGuideView *guideView = [LSPushGuideView viewFromXib];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
