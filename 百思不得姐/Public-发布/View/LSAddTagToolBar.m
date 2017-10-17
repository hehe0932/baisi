//
//  LSAddTagToolBar.m
//  百思不得姐
//
//  Created by chenlishuang on 2017/9/27.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSAddTagToolBar.h"
#import "LSAddTagViewController.h"
@interface LSAddTagToolBar()
@property (weak, nonatomic) IBOutlet UIView *topView;

@end
@implementation LSAddTagToolBar

- (void)awakeFromNib{
    [super awakeFromNib];
    //添加一个加号按钮
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
//    addButton.size = [UIImage imageNamed:@"tag_add_icon"].size;
//    addButton.size = [addButton imageForState:UIControlStateNormal].size;
    addButton.size = addButton.currentImage.size;
    addButton.x = topicCellMargin;
    
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:addButton];
}

- (void)addButtonClick{
    LSAddTagViewController *addVC = [LSAddTagViewController new];
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *) rootVC.presentedViewController ;
    [nav pushViewController:addVC animated:YES];
}
@end
