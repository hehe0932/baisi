//
//  UIView+LSExtension.h
//  百思不得姐
//
//  Created by chenlishuang on 17/1/11.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LSExtension)
/* 在分类中什么@proerty,只会生成方法的声明,不会生成方法得实现和带有_下划线的成员变量*/

/** X坐标 */
@property(assign,nonatomic)CGFloat x;
/** Y坐标 */
@property(assign,nonatomic)CGFloat y;
/** 宽度 */
@property(assign,nonatomic)CGFloat width;
/** 高度 */
@property(assign,nonatomic)CGFloat height;
//完善  两个属性  centerX  centerY
/** 中心 */
@property(assign,nonatomic)CGFloat centerX;
@property(assign,nonatomic)CGFloat centerY;

/** 尺寸 */
@property(assign,nonatomic)CGSize size;

/**
 *  判断控件是否真正的显示在屏幕上
 */
-(BOOL)isShowingOnWindow;
@end
