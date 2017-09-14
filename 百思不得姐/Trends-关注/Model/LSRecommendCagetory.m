//
//  LSRecommendCagetory.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/12.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//  推荐左边的数据模型

#import "LSRecommendCagetory.h"
#import <MJExtension.h>
@implementation LSRecommendCagetory
- (NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}
@end
