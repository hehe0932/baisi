//
//  LSTopicCell.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/20.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSTopicCell.h"
#import "LSTopic.h"
#import <UIImageView+WebCache.h>
#import "LSTopicPictureView.h"
#import "LSTopicVoiceView.h"
#import "LSTopicVideoView.h"
#import "LSComment.h"
#import "LSUser.h"
@interface LSTopicCell()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *pofileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 新浪加V */
@property (weak, nonatomic) IBOutlet UIImageView *sinaV;
/** 帖子的文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;
/** 图片帖子中间的内容 */
@property (weak, nonatomic) LSTopicPictureView *pictureView;
/** 声音帖子中间的内容 */
@property (weak, nonatomic) LSTopicVoiceView *voiceView;
/** 视频帖子中间的内容 */
@property (weak, nonatomic) LSTopicVideoView *videoView;
/** 最热评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
/** 最热评论整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@end
@implementation LSTopicCell

- (LSTopicPictureView *)pictureView{
    if (!_pictureView) {
        LSTopicPictureView *pictureView = [LSTopicPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
- (LSTopicVoiceView *)voiceView{
    if (!_voiceView) {
        LSTopicVoiceView *voiceView = [LSTopicVoiceView viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}
- (LSTopicVideoView *)videoView{
    if (!_videoView) {
        LSTopicVideoView *videoView = [LSTopicVideoView viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.backgroundView = bgView;

//    self.pofileImageView.layer.cornerRadius = self.pofileImageView.width * 0.5;
//    self.pofileImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setTopic:(LSTopic *)topic{
    _topic = topic;
    
    [self.pofileImageView setCircleHeader:topic.profile_image];
    self.nameLabel.text = topic.name;
    //设置帖子的创建时间  设置在get方法里了
    self.creatTimeLabel.text = topic.create_time;

    //设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"转发"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    //新浪加V
    self.sinaV.hidden = !topic.isSinaV;
//    [self testDate:topic.create_time];
    //设置帖子的文字内容
    self.text_label.text = topic.text;
    
    //根据模型类型(帖子类型)添加对应的内容到cell的中间
    if (topic.type == topicTypePicture) {
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureViewFrame;
    }else if (topic.type == topicTypeVoice){//声音帖子
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.frame = topic.voiceViewFrame;
        self.voiceView.topic = topic;
    }else if (topic.type == topicTypeVideo){//视频帖子
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
        self.videoView.frame = topic.videoViewF;
        self.videoView.topic = topic;
    }else{//段子帖子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
        
    }
    //处理最热评论
    if (topic.top_cmt) {
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",topic.top_cmt.user.username,topic.top_cmt.content];
        self.topCmtView.hidden = NO;
    }else{
        self.topCmtView.hidden = YES;
    }
}

/**
 设置按钮文字
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder{
    
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }else if(count > 0){
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeholder forState:(UIControlStateNormal)];
}
- (void)setFrame:(CGRect)frame{
//    static CGFloat margin = 10;//static只触发一次
//    frame.origin.x =topicCellMargin;
//    frame.size.width-=2*frame.origin.x;
    frame.size.height = self.topic.cellHeight - topicCellMargin;
    frame.origin.y+=topicCellMargin;
    [super setFrame:frame];
}

/**
 今年
     今天
         1分钟内:刚刚
         1小时内:XX分钟前
         其他:XX小时前
     昨天
         昨天 16:13:00
     其他
        01-20 16:13:00
 非今年:2017-01-20 16:13:00
 */


- (void)testDate:(NSString*)create_time{
    //日期格式化类
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //设置日期格式
    formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    //当前时间
    NSDate *now = [NSDate date];
    //创建时间
    NSDate *creat = [formatter dateFromString:create_time];
    //日历类
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //获得NSDate每个元素
//    NSInteger yesr = [calendar component:NSCalendarUnitYear fromDate:now];
//    NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:now];
//    NSInteger day = [calendar component:NSCalendarUnitDay fromDate:now];
    
//    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    
    //比较时间
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitSecond|NSCalendarUnitMinute;
    NSDateComponents *components = [calendar components:unit fromDate:creat toDate:now options:0];
    LSLog(@"%@",components);
    
}

//- (void)testDate:(NSString*)create_time{
//    //当前时间
//    NSDate *now = [NSDate date];
//    //发帖时间
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    //设置日期格式
//    formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
//    NSDate *creat = [formatter dateFromString:create_time];
//    NSTimeInterval interval = [now timeIntervalSinceDate:creat];
//    
//    
//}
- (IBAction)more:(id)sender {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
   UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:action];
    [alertVC addAction:action2];
    [alertVC addAction:action3];
    [self.window.rootViewController presentViewController:alertVC animated:YES completion:nil];
}


@end
