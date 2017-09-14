//
//  LSRecommendCagetory.h
//  百思不得姐
//
//  Created by chenlishuang on 17/1/12.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSRecommendCagetory : NSObject
/** ID */
@property (nonatomic,assign)NSInteger ID;
/** 总数 */
@property (nonatomic,assign)NSInteger count;
/** 名字 */
@property (nonatomic,copy)NSString *name;


/** 这个类别对应的用户数据 */
@property (nonatomic,strong) NSMutableArray *users;
/** 总数 */
@property (nonatomic,assign)NSInteger total;
/** 当前页码 */
@property (nonatomic,assign)NSInteger currentPage;

@end
