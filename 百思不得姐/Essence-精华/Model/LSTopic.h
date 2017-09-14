//
//  LSTopic.h
//  百思不得姐
//
//  Created by chenlishuang on 17/1/20.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//  帖子

#import <UIKit/UIKit.h>

@interface LSTopic : NSObject
/** 名字*/
@property (nonatomic,copy)NSString *name;
/** 头像*/
@property (nonatomic,copy)NSString *profile_image;
/** 发帖时间*/
@property (nonatomic,copy)NSString *create_time;
/** 文字内容*/
@property (nonatomic,copy)NSString *text;
/** 顶的数量*/
@property (nonatomic,assign)NSInteger ding;
/** 踩的数量*/
@property (nonatomic,assign)NSInteger cai;
/** 转发的数量*/
@property (nonatomic,assign)NSInteger repost;
/** 评论的数量*/
@property (nonatomic,assign)NSInteger comment;
/** 新浪加V*/
@property (nonatomic,assign,getter=isSinaV)BOOL sina_v;
/** 图片的宽度*/
@property (nonatomic,assign)CGFloat width;
/** 图片的高度*/
@property (nonatomic,assign)CGFloat height;
/** 小图片的URL*/
@property (nonatomic,copy)NSString *small_image;
/** 大图片的URL*/
@property (nonatomic,copy)NSString *large_image;
/** 中图片的URL*/
@property (nonatomic,copy)NSString *middle_image;
/** 帖子类型*/
@property (nonatomic,assign)TopicType type;

/** 音频时长*/
@property (nonatomic,assign)NSInteger voicetime;
/** 播放次数*/
@property (nonatomic,assign)NSInteger playcount;
/** 视频时长*/
@property (nonatomic,assign)NSInteger videotime;

/** 最热评论(期望这个数组中存放的是LSComment模型)*/
@property (nonatomic,strong)NSArray *top_cmt;
/*********** 额外的辅助属性 ***********/
/** cell的高度*/
@property (nonatomic,assign,readonly)CGFloat cellHeight;
/** 图片空间的frame*/
@property (nonatomic,assign,readonly)CGRect pictureViewFrame;
/** 图片是否太大*/
@property (nonatomic,assign,getter=isBigPicture)BOOL bigPicture;

/** 声音控件的frame*/
@property (nonatomic,assign,readonly)CGRect voiceViewFrame;
/** 视频控件的frame*/
@property (nonatomic,assign,readonly)CGRect videoViewF;
@end
