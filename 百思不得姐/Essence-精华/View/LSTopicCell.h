//
//  LSTopicCell.h
//  百思不得姐
//
//  Created by chenlishuang on 17/1/20.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSTopic;
@interface LSTopicCell : UITableViewCell
/** 帖子数据模型 */
@property (nonatomic,strong)LSTopic *topic;
@end
