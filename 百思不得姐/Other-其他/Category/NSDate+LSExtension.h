//
//  NSDate+LSExtension.h
//  百思不得姐
//
//  Created by chenlishuang on 17/1/20.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LSExtension)

/**
 比较from和self的时间差
 */
- (NSDateComponents *)dateFrom:(NSDate *)from;

/**
 是否是今年
 */
- (BOOL)isThisYear;
/**
 是否是今天
 */
- (BOOL)isToday;
/**
 是否是昨天
 */
- (BOOL)isYesterday;
@end
