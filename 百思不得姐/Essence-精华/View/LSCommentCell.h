//
//  LSCommentCell.h
//  百思不得姐
//
//  Created by chenlishuang on 2017/9/21.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSComment;
@interface LSCommentCell : UITableViewCell
/** 评论模型*/
@property (nonatomic,strong)LSComment *comment;
@end
