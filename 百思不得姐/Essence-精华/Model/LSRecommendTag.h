//
//  LSRecommendTag.h
//  百思不得姐
//
//  Created by chenlishuang on 17/1/16.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSRecommendTag : NSObject
/** 图片*/
@property (nonatomic,copy)NSString *image_list;
/** 名字*/
@property (nonatomic,copy)NSString  *theme_name;
/** 订阅数*/
@property (nonatomic,assign)NSInteger sub_number;
@end
