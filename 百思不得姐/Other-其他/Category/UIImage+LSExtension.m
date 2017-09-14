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
@end
