//
//  LSTopicVideoView.m
//  百思不得姐
//
//  Created by chenlishuang on 2017/8/9.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSTopicVideoView.h"
#import "LSTopic.h"
#import <UIImageView+WebCache.h>
#import "LSShowPictureController.h"
@interface LSTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *videoCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;

@end
@implementation LSTopicVideoView


- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;//给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
    
}
- (void)showPicture{
    LSShowPictureController *showVC = [[LSShowPictureController alloc]init];
    showVC.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showVC animated:YES completion:nil];
}

- (void)setTopic:(LSTopic *)topic{
    _topic = topic;
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    //播放次数
    self.videoCountLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    //时长
    NSInteger minute = topic.videotime/60;
    NSInteger second = topic.videotime%60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

@end
