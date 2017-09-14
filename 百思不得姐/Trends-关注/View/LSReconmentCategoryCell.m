//
//  LSReconmentCategoryCell.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/12.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSReconmentCategoryCell.h"
#import "LSRecommendCagetory.h"

@interface LSReconmentCategoryCell() 
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end
@implementation LSReconmentCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = LSRGBColor(244, 244, 244);
    self.textLabel.font = [UIFont systemFontOfSize:16];
    //当cell的selection为None时,即使cell被选中时,内部的子控件也不会进入高亮状态
    //    self.textLabel.highlightedTextColor = LSRGBColor(219, 21, 26);
}

/**
 可以在这个方法中监听cell的选中和取消选中
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected?LSRGBColor(219, 21, 26):LSRGBColor(78, 78, 78);
}

- (void)setCategory:(LSRecommendCagetory *)category{
    _category = category;
    self.textLabel.text = category.name;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //重新调整内部的textLabel
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}
@end
