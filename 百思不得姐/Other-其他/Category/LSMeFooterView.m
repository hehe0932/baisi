//
//  LSMeFooterView.m
//  百思不得姐
//
//  Created by chenlishuang on 2017/9/25.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSMeFooterView.h"
#import <AFNetworking.h>
#import "LSSquare.h"
#import <MJExtension.h>
#import "LSWebViewController.h"
#import "LSSquareButton.h"
@implementation LSMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *squares = [LSSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            //创建方块
            [self createSquare:squares];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    return self;
}
/**
 创建方块
 */
- (void)createSquare:(NSArray *)squares{
    //一行最多4列
    int maxCols = 4;
    
    //宽度和高度
    CGFloat buttonW = ScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i<squares.count; i++) {
        LSSquareButton * button = [LSSquareButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        button.square = squares[i];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        int col = i%maxCols;
        int row = i/maxCols;
        
        button.x = col * buttonW;
        button.y = row *buttonH;
        button.width = buttonW;
        button.height = buttonH;
        
        //计算footerView高度 或者用下面的方法
//        self.height = CGRectGetMaxY(button.frame);
    }
    
    //7个方块,每行显示4个 计算行数7/4 == 1 2
    //8个方块,每行显示4个 计算行数8/4 == 2 2
    //9个方块,每行显示4个 计算行数9/4 == 2 3
    
    //总行数
//    NSUInteger rows = squares.count / maxCols;
//    if (squares.count % maxCols) { //不能整除   +1
//        rows ++;
//    }
    

    //总页数 = (总个数 + 每页最大数 - 1)/每页最大数
    NSUInteger rows = (squares.count + maxCols - 1)/maxCols;
    self.height = rows * buttonH;
    //重绘
    [self setNeedsDisplay];
}

//设置背景图片
//- (void)drawRect:(CGRect)rect{
//    [[UIImage imageNamed:@"mainCellBackground"]drawInRect:rect];
//}

- (void)buttonClick:(LSSquareButton *)button{
    if (![button.square.url hasPrefix:@"http"]) {
        return;
    }
    
    LSWebViewController *webVC= [[LSWebViewController alloc]init];
    webVC.url = button.square.url;
    webVC.title = button.square.name;
    
    //取出当前的导航控制器
    UITabBarController *tabbarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabbarVC.selectedViewController;
    [nav pushViewController:webVC animated:YES];
}
@end
