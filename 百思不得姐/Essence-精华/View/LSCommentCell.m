//
//  LSCommentCell.m
//  百思不得姐
//
//  Created by chenlishuang on 2017/9/21.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSCommentCell.h"
#import "LSComment.h"
#import <UIImageView+WebCache.h>
#import "LSUser.h"
@interface LSCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *prefileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end
@implementation LSCommentCell

- (void)setComment:(LSComment *)comment{
    _comment = comment;
    
    [self.prefileImageView setCircleHeader:comment.user.profile_image];
    self.sexImageView.image = [comment.user.sex isEqualToString:LSUserSexMale]?[UIImage imageNamed:@"Profile_manIcon"]:[UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.userNameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    if (comment.voiceurl.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd'",comment.voiceurl] forState:UIControlStateNormal];
    }else{
        self.voiceButton.hidden = YES;
    }
}
- (void)setFrame:(CGRect)frame{
//    frame.origin.x = topicCellMargin;
//    frame.size.width -= 2*topicCellMargin;
    [super setFrame:frame];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.backgroundView = bgView;
}


- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
}
@end
