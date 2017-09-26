//
//  UIImageView+LSExtension.m
//  百思不得姐
//
//  Created by chenlishuang on 2017/9/25.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "UIImageView+LSExtension.h"
#import <UIImageView+WebCache.h>
@implementation UIImageView (LSExtension)
- (void)setCircleHeader:(NSString *)url{
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image =image? [image circleImage]:placeholder;
    }];
}
@end
