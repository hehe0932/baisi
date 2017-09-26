//
//  LSPublicViewController.m
//  百思不得姐
//
//  Created by chenlishuang on 17/2/8.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSPublicViewController.h"
#import "LSVerticalButton.h"
#import <POP.h>
#import "LSPostWordViewController.h"
#import "LSNavigationController.h"
static CGFloat const animationDelay = 0.1;
static CGFloat const springFactor = 10;
@interface LSPublicViewController ()

@end

@implementation LSPublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //让控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    //数据
    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审核",@"离线下载"];
    //中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (ScreenH-2*buttonH)*0.5;
    CGFloat buttonStratX = 20;
    CGFloat xMargin = (ScreenW - 2*buttonStratX - maxCols * buttonW)/(maxCols - 1);
    for (int i = 0; i<images.count; i++) {
        LSVerticalButton *button = [[LSVerticalButton alloc]init];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:button];
        
        //设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        button.tag = i;
        button.size = CGSizeMake(buttonW, buttonH);
        //计算X Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStratX + col * (buttonW + xMargin);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = -buttonEndY-ScreenH;
        
        //添加动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = springFactor;
        anim.springSpeed = springFactor;
        anim.beginTime = CACurrentMediaTime()+animationDelay*i;
        [button pop_addAnimation:anim forKey:nil];
        
    }
    //添加标语
    UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];

    [self.view addSubview:sloganView];
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = ScreenW*0.5;
    CGFloat centerEndY = ScreenH * 0.2;
    CGFloat centerbeginY = centerEndY - ScreenH;
    
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerbeginY)] ;
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.springBounciness = springFactor;
    anim.springSpeed = springFactor;
    anim.beginTime = CACurrentMediaTime()+images.count*animationDelay;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
        //恢复点击事件
        self.view.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
    
}
- (IBAction)cancel:(id)sender {
    
    [self cancelWithCompletionBlock:nil];
}


/**
 pop和Core Animation的区别
 1.Core Animation动画只能添加到layer上面
 2.pop的动画能添加到任何对象
 3.pop的底层并非基于Core Animation,而是基于CADisplayLink
 4.Core Animation的动画仅仅是表象,并不会修改frame/size等值
 5.pop的动画实时修改对象的属性,真正的修改对象属性
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancel:nil];
//    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
//    animation.springSpeed = 20;
//    animation.springBounciness = 20;
//    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
//    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
//    [self.sloganView pop_addAnimation:animation forKey:@"123"];
}
- (void)buttonClick:(UIButton *)button{
    
    [self cancelWithCompletionBlock:^{
        if (button.tag == 2) {
            LSPostWordViewController *postWord = [[LSPostWordViewController alloc]init];
            LSNavigationController *nav = [[LSNavigationController alloc]initWithRootViewController:postWord];
            //这里不能使用时self来弹出控制器 因为self执行了dismiss操作
            UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
            [rootVC presentViewController:nav animated:YES completion:nil];
            NSLog(@"发段子");
        }
    }];
}

- (void)cancelWithCompletionBlock:(void(^)())block{
    //让控制器的View不能被点击
    self.view.userInteractionEnabled = NO;
    int beginIndex = 2;
    for (int i = beginIndex;i < self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + ScreenH;
        //动画执行的节奏(一开始很慢,后面加速)
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        
        anim.beginTime = CACurrentMediaTime()+(i-beginIndex)*animationDelay;
        [subview pop_addAnimation:anim forKey:nil];
        //监听最后一个动画
        if (i==self.view.subviews.count-1) {
            [anim setCompletionBlock:^(POPAnimation *animation, BOOL finish) {
                
                [self dismissViewControllerAnimated:NO completion:nil];
                
                !block?:block();
            }];
        }
    }

}
@end
