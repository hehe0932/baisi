//
//  LSTopicPictureView.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/25.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSTopicPictureView.h"
#import "LSTopic.h"
#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>
#import "LSShowPictureController.h"
@interface LSTopicPictureView()

/** 图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** gif图片*/
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
/** 查看大图按钮*/
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
/** 进度条控件*/
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end
@implementation LSTopicPictureView


- (void)awakeFromNib{
    [super awakeFromNib];
    //默认拉伸了
    self.autoresizingMask = UIViewAutoresizingNone;
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
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
    
    /**
     在不知道图片的扩展名的情况下,如何知道图片的类型:去除图片的第一个字节,就可以判断出图片的真实类型
     */
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        CGFloat progress = 1.0*receivedSize/expectedSize;
        NSString *text = [NSString stringWithFormat:@"%.0f%%",progress*100];
        [self.progressView setProgress:progress];
        self.progressView.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        //如果是大图片 才需要绘图处理
        if (topic.isBigPicture == NO) {
            return ;
        }
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureViewFrame.size, YES, 0.0);
        //将下载完的image对象绘制到图形上下文
        CGFloat width = topic.pictureViewFrame.size.width;
        CGFloat height = width * image.size.height/image.size.width;
        [image drawInRect:CGRectMake(0, 0,width,height)];
        //获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        //结束图形上下文
        UIGraphicsEndImageContext();
    }];
    //判断是否为gif(根据URL的扩展名.pathExtension)
    NSString *extension = topic.large_image.pathExtension;
    //lowercaseString先转换成小写
    self.gifImageView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    //判断是否显示"点击查看全图"按钮
    if (topic.isBigPicture) {//大图
        self.seeBigButton.hidden = NO;
//        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{//非大图
        self.seeBigButton.hidden = YES;
//        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
    
}
@end
