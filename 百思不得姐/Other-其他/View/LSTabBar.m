//
//  LSTabBar.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/11.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSTabBar.h"
#import "LSPublicViewController.h"
@interface LSTabBar()
@property (nonatomic,weak)UIButton *publicBtn;
@end
@implementation LSTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        UIButton *publicBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [publicBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:(UIControlStateNormal)];
        [publicBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon_click"] forState:(UIControlStateHighlighted)];
        publicBtn.size = publicBtn.currentBackgroundImage.size;
        
        [publicBtn addTarget:self action:@selector(publicClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publicBtn];
        self.publicBtn = publicBtn;
    }
    return self;
}
//重新布局
- (void)layoutSubviews{
    [super layoutSubviews];
    //设置发布按钮的frame
//    self.publicBtn.bounds = CGRectMake(0, 0, self.publicBtn.currentBackgroundImage.size.width, self.publicBtn.currentBackgroundImage.size.height);
    self.publicBtn.center = CGPointMake(self.width*0.5, self.height*0.5);
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width/5;
    CGFloat buttonH = self.height;
    NSInteger index = 0;
    //设置其他tabbarButton的frame
    //注意点:UITabBarButton 是系统没有提供出来的一个类!!

    for (UIView *button in self.subviews) {
        if ([button isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //计算按钮的x值
            CGFloat buttonX = buttonW * ((index > 1)?index+1:index);
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            //增加索引
            index++;
        }
    }
}
- (void)publicClick{
    
    LSPublicViewController *publicVC = [[LSPublicViewController alloc]init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publicVC animated:NO completion:nil];
}
@end
