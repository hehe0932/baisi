//
//  UIBarButtonItem+LSExtension.h
//  百思不得姐
//
//  Created by chenlishuang on 17/1/11.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LSExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
