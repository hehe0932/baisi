//
//  LSCommentViewController.h
//  百思不得姐
//
//  Created by chenlishuang on 2017/9/14.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSTopic;
@interface LSCommentViewController : UIViewController
/** 帖子模型*/
@property (nonatomic,strong)LSTopic *topic;
@end
