//
//  UIImage+LSExtension.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/10.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "UIImage+LSExtension.h"

@implementation UIImage (LSExtension)
+ (UIImage *)originalImageName:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}
+ (UIImage *)ls_originalImageName:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

- (UIImage *)circleImage{
    
    //NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    //获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    //裁剪
    CGContextClip(ctx);
    
    //将图片画上去
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
