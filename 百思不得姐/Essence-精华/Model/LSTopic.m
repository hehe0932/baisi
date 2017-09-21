//
//  LSTopic.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/20.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSTopic.h"
//#import <MJExtension.h>
#import "LSComment.h"
#import "LSComment.h"
#import "LSUser.h"
@implementation LSTopic
{
    CGFloat _cellHeight;
//    CGRect _pictureViewFrame;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"small_image":@"image0",
             @"large_image":@"image1",
             @"middle_image":@"image2",
             @"ID":@"id",
             @"top_cmt":@"top_cmt[0]"
             };
}


- (NSString *)create_time{
    //日期格式化类
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //设置日期格式
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //创建时间
    NSDate *creat = [formatter dateFromString:_create_time];
    if (creat.isThisYear) {//今年
        if (creat.isToday) {
            NSDateComponents *components = [[NSDate date]dateFrom:creat];
            if (components.hour>=1) {//时间差:大于1小时
                return [NSString stringWithFormat:@"%zd小时前",components.hour];
            }else if(components.minute>=1){//1小时>=时间差>=1分钟
                return [NSString stringWithFormat:@"%zd分钟前",components.minute];
            }else{//时间差小于1分钟
                return @"刚刚";
            }
        }else if (creat.isYesterday){
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return  [formatter stringFromDate:creat];
        }else{
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:creat];
        }
    }else{//非今年
        return _create_time;
    }

}
- (CGFloat)cellHeight{
    if (!_cellHeight) {
        //文字的Y值
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-40, MAXFLOAT);
        //    CGFloat textH = [topic.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxSize].height;
        //计算文字高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        //cell的高度
        _cellHeight = topicCellTextY+textH+topicCellMargin;
        
        //根据段子的类型来计算cell高度
        if (self.type == topicTypePicture) {//图片
            //图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            //图片显示出来的高度
            CGFloat pictureH = pictureW * self.height/self.width;
            if (pictureH >= topicCellPictureMaxH) {//图片过长
                pictureH = topicCellPictureBreakH;
                self.bigPicture = YES;//大图
            }
            //计算图片的frame
            CGFloat pictureX = topicCellMargin;
            CGFloat pictureY = topicCellTextY + textH + topicCellMargin;
            _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            _cellHeight+= pictureH+topicCellMargin;
        }else if (self.type == topicTypeVoice){
            CGFloat voiceX = topicCellMargin;
            CGFloat voiceY = topicCellTextY + textH + topicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height/self.width;
            _voiceViewFrame = CGRectMake(voiceX,voiceY,voiceW,voiceH);
            _cellHeight += voiceH + topicCellMargin;
        }else if (self.type == topicTypeVideo){
            CGFloat videoX = topicCellMargin;
            CGFloat videoY = topicCellTextY + textH + topicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height/self.width;
            _videoViewF = CGRectMake(videoX,videoY,videoW,videoH);
            _cellHeight += videoH + topicCellMargin;
        }
        //如果有最热评论
        if (self.top_cmt) {
            NSString *content = [NSString stringWithFormat:@"%@ : %@",self.top_cmt.user.username,self.top_cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += LSTopicCellTopCmtTitleH + contentH +topicCellMargin;
        }
        //底部工具条的高度
        _cellHeight += topicCellBottomBarH + topicCellMargin;
    }
    return _cellHeight;
}
@end
