//
//  LSUser.h
//  百思不得姐
//
//  Created by chenlishuang on 2017/8/10.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSUser : NSObject
/** 用户名*/
@property (nonatomic,copy)NSString *username;
/** 性别*/
@property (nonatomic,copy)NSString *sex;
/** 头像*/
@property (nonatomic,copy)NSString *profile_image;
@end
