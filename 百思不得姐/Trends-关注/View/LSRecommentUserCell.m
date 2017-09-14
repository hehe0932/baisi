//
//  LSRecommentUserCell.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/13.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSRecommentUserCell.h"
#import "LSRecommentUser.h"
#import <UIImageView+WebCache.h>
@interface LSRecommentUserCell()
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@end
@implementation LSRecommentUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setUser:(LSRecommentUser *)user{
    _user = user;
    self.screenNameLabel.text = user.screen_name;
    NSString *fansCount = nil;
    if (user.fans_count<10000) {
        fansCount = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    }else{//大于等于1万
        fansCount = [NSString stringWithFormat:@"%.1f万人关注",user.fans_count/10000.0];
    }
    self.fansCountLabel.text = fansCount;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] ];
}
@end
