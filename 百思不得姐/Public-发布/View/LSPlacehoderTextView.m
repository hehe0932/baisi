//
//  LSPlacehoderTextView.m
//  百思不得姐
//
//  Created by chenlishuang on 2017/9/26.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSPlacehoderTextView.h"

@implementation LSPlacehoderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        
        //监听文字改变
        [LSNoteCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
//每次调用drawRect之前,会自动清除掉之前绘制的内容
- (void)drawRect:(CGRect)rect {
    //如果有文字,直接返回,不绘制占位文字
//    if (self.text.length || self.attributedText.length) return;
    if (self.hasText)return;
    //处理rect
    rect.origin.x = 3;
    rect.origin.y = 8;
    rect.size.width -= 2 * rect.origin.x;
    NSMutableDictionary *attDic = [NSMutableDictionary dictionary];
    attDic[NSFontAttributeName] = self.font;
    attDic[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    [self.placeholder drawInRect:rect withAttributes:attDic];
}

- (void)textDidChange{
    [self setNeedsDisplay];
}

- (void)dealloc{
    [LSNoteCenter removeObserver:self];
}
@end
