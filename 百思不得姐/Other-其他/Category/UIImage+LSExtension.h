//
//  UIImage+LSExtension.h
//  百思不得姐
//
//  Created by chenlishuang on 17/1/10.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LSExtension)
+ (UIImage *)originalImageName:(NSString *)name NS_DEPRECATED_IOS(2_0, 3_0,"过期了~~~用ls_方法") __TVOS_PROHIBITED;
+ (UIImage *)ls_originalImageName:(NSString *)name;
@end
