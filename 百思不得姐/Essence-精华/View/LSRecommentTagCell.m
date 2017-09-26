//
//  LSRecommentTagCell.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/16.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSRecommentTagCell.h"
#import "LSRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface LSRecommentTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end
@implementation LSRecommentTagCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRecommendTag:(LSRecommendTag *)recommendTag{
    _recommendTag = recommendTag;
//    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [self.imageListImageView setCircleHeader:recommendTag.image_list];
    self.themeNameLabel.text = recommendTag.theme_name;
    NSString *subNum = nil;
    if (recommendTag.sub_number<10000) {
        subNum = [NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    }else{//大于等于1万
        subNum = [NSString stringWithFormat:@"%.1f万人订阅",recommendTag.sub_number/10000.0];
    }
    self.subNumberLabel.text = subNum;
}
- (void)setFrame:(CGRect)frame{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}
@end
