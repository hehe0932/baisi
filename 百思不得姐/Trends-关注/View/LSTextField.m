//
//  LSTextField.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/17.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSTextField.h"
#import <objc/runtime.h>

@implementation LSTextField

//- (void)drawPlaceholderInRect:(CGRect)rect{
//    [self.placeholder drawInRect:CGRectMake(0, 10, rect.size.width, 25) withAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:self.font}];
//}
//+ (void)initialize{
//    unsigned int count = 0;
//    //拷贝出所有成员变量列表
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    for (int i = 0; i<count; i++) {
//        //取出成员变量
//        Ivar ivar = *(ivars +i);
//        //可以当成数组用
//        //Ivar ivar = ivars[i];
//        //打印成员变量的名字
//        LSLog(@"%s",ivar_getName(ivar));
//    }
//    //释放
//    free(ivars);
//}
/**
 运行时(runtime):苹果官方的c语言库
 能错很多底层操作(比如访问隐藏的成员变量,方法等等)
 */

- (void)awakeFromNib{
    [super awakeFromNib];
    //第一种
//    UILabel *placeholderLabel = [self valueForKeyPath:@"_placeholderLabel"];
//    placeholderLabel.textColor = [UIColor redColor];
    //另一种
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    //设置光标颜色和占位颜色一致
    self.tintColor = self.textColor;
    
    //不成为第一响应者
    [self resignFirstResponder];
}
//聚焦就会来这里
//- (void)setHighlighted:(BOOL)highlighted{
//    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
//}
//文本框聚焦
- (BOOL)becomeFirstResponder{
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}
//文本框失去焦点
- (BOOL)resignFirstResponder{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    
}
@end
