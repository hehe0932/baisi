//
//  LSRecommentUser.h
//  百思不得姐
//
//  Created by chenlishuang on 17/1/13.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSRecommentUser : NSObject
/** 头像 */
@property (nonatomic,copy)NSString *header;
/** 粉丝数 */
@property (nonatomic,assign)NSInteger fans_count;
/** 昵称 */
@property (nonatomic,copy)NSString *screen_name;
/** 页数 */
@property (nonatomic,assign)NSInteger page;




@end
