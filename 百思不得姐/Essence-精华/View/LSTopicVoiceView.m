//
//  LSTopicVoiceView.m
//  百思不得姐
//
//  Created by chenlishuang on 2017/8/9.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSTopicVoiceView.h"
#import "LSTopic.h"
#import <UIImageView+WebCache.h>
#import "LSShowPictureController.h"
@interface LSTopicVoiceView()
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation LSTopicVoiceView


- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    //给图片添加监听器
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
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    //时长
    NSInteger minute = topic.voicetime/60;
    NSInteger second = topic.voicetime%60;
    self.voiceTimeLable.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}
@end
