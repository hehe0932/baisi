//
//  LSMeCell.m
//  百思不得姐
//
//  Created by chenlishuang on 2017/9/25.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSMeCell.h"

@implementation LSMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        self.backgroundView = bgView;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:15];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) {
        return;
    }
    self.imageView.width = 30;
    self.imageView.height = 30;
    self.imageView.centerY = self.contentView.height * 0.5;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + topicCellMargin;
}

- (void)setFrame:(CGRect)frame{
    frame.origin.y -= (35 - topicCellMargin);
    [super setFrame:frame];
}
@end
