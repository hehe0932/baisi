//
//  LSTopicViewController.h
//  百思不得姐
//
//  Created by chenlishuang on 17/1/22.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSTopicViewController : UITableViewController
/** 帖子类型(交给子类去实现)*/
@property (nonatomic,assign)TopicType topicType;
@end
