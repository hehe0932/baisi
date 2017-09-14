//
//  LSEssenceViewController.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/11.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSEssenceViewController.h"
#import "LSRecommentTagsViewController.h"
#import "LSTopicViewController.h"
@interface LSEssenceViewController ()<UIScrollViewDelegate>
/** 标签栏底部的红色指示器 */
@property (nonatomic,weak)UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic,weak)UIButton *selectedButton;
/** 顶部的所有标签 */
@property (nonatomic,weak)UIView *titlesView;
/** 底部的所有内容 */
@property (nonatomic,weak)UIScrollView *contentView;
@end

@implementation LSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏内容
    [self setupNav];
    //初始化子控制器
    [self setupChildVCs];
    //设置顶部标签
    [self setupTitlesView];
    //底部的ContentView
    [self setupContentView];
    
}
- (void)setupChildVCs{
    LSTopicViewController *all = [[LSTopicViewController alloc]init];
    all.title = @"全部";
    all.topicType = 1;
    [self addChildViewController:all];
    
    LSTopicViewController *video = [[LSTopicViewController alloc]init];
    video.title = @"视频";
    video.topicType = 41;
    [self addChildViewController:video];
    
    LSTopicViewController *voice = [[LSTopicViewController alloc]init];
    voice.title = @"声音";
    voice.topicType = 31;
    [self addChildViewController:voice];
        
    LSTopicViewController *picture = [[LSTopicViewController alloc]init];
    picture.title = @"图片";
    picture.topicType = 10;
    [self addChildViewController:picture];
    
    LSTopicViewController *word = [[LSTopicViewController alloc]init];
    word.title = @"段子";
    word.topicType = 29;
    [self addChildViewController:word];
    

    
}
/**
 设置导航栏
 */
- (void)setupNav{
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagButtonAction)];
    self.view.backgroundColor = LSGlobaBg;
    
    //    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
}

/**
 设置顶部的标签栏
 */
- (void)setupTitlesView{
    //标签栏整体
    UIView *titleView = [[UIView alloc]init];
//    titleView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
//    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    titleView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
    titleView.width = self.view.width;
    titleView.height = titlesViewH;
    titleView.y = titlesViewY;
    [self.view addSubview:titleView];
    self.titlesView = titleView;
    //底部的红色指示器
    UIView *indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titleView.height-indicatorView.height;
   
    self.indicatorView = indicatorView;
    
    //内部子标签
//    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat width = titleView.width/self.childViewControllers.count;
    CGFloat height = titleView.height;
    for (NSInteger i = 0; i<self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.height = height;
        button.width = width;
        button.x = i*width;
        button.tag = i;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:(UIControlStateNormal)];
//        [button layoutIfNeeded];//强制布局子控件frame
        [button setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor redColor] forState:(UIControlStateDisabled)];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [titleView addSubview:button];
        
        //默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            //让按钮内部的label根据文字内容计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.centerX;
            self.indicatorView.centerX = button.centerX;
        }
    }
    [titleView addSubview:indicatorView];
}
- (void)titleClick:(UIButton *)button{
    //修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    //动画
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.width = button.titleLabel.centerX;
        self.indicatorView.centerX = button.centerX;
    }];
    
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag*self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

/**
 设置底部的ContentView
 */
- (void)setupContentView{
    //不要自动调整Inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc]init];
//    contentView.backgroundColor = [UIColor darkGrayColor];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    
    [self.view addSubview:contentView];
    
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width*self.childViewControllers.count, 0);
    contentView.pagingEnabled = YES;
    self.contentView = contentView;
    
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}
//进入推荐标签页
- (void)tagButtonAction {
    LSRecommentTagsViewController *tagsVC = [[LSRecommentTagsViewController alloc]init];
    [self.navigationController pushViewController:tagsVC animated:YES];
}
#pragma mark -<UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //添加子控制器的view
    //当前的索引
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    //取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;//设置控制器view的y值为0(默认为20)
    vc.view.height = scrollView.height;//设置控制器的view的height等于整个屏幕的高度(默认是比屏幕少20)
   
    [scrollView addSubview:vc.view];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //点击按钮
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
