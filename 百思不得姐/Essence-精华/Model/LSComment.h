//
//  LSComment.h
//  百思不得姐
//
//  Created by chenlishuang on 2017/8/10.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSUser;
@interface LSComment : NSObject
/** 音频文件的时长*/
@property (nonatomic,assign)NSInteger voicetime;
/** 评论的文字内容*/
@property (nonatomic,copy)NSString *content;
/** 被点赞数量*/
@property (nonatomic,assign)NSInteger like_count;
/** 用户*/
@property (nonatomic,strong)LSUser *user;
@end
