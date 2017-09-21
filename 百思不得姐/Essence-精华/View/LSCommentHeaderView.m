//
//  LSCommentHeaderView.m
//  百思不得姐
//
//  Created by chenlishuang on 2017/9/21.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSCommentHeaderView.h"

@interface LSCommentHeaderView()
/** 文字标签*/
@property (nonatomic,strong)UILabel *label;
@end

@implementation LSCommentHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = LSGlobaBg;
        //创建内容
        UILabel *label = [[UILabel alloc]init];
        label.textColor = LSRGBColor(67, 67, 67);
        label.width = 200;
        label.x = topicCellMargin;
//        label.tag = LSHeaderLabelTag;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}
- (void)setTitle:(NSString *)title{
    _title = [title copy];
    self.label.text = title;
}
@end
