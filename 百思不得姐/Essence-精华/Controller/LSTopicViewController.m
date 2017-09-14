//
//  LSTopicViewController.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/19.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSTopicViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "LSTopic.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "LSTopicCell.h"
@interface LSTopicViewController ()
/** 帖子数据 */
@property (nonatomic,strong)NSMutableArray *topics;
/** 当前页面 */
@property (nonatomic,assign)NSInteger page;
/** 当加载下一页数据时,需要这个参数 */
@property (nonatomic,copy)NSString *maxtime;
/** 上一次请求的参数 */
@property (nonatomic,strong)NSDictionary *params;
@end

@implementation LSTopicViewController

- (NSMutableArray *)topics{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化表格
    [self setupTableView];
    //添加刷新控件
    [self setupRefresh];
    
    
}
static NSString * const topicCellID = @"topic";
- (void)setupTableView{
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = titlesViewY+titlesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LSTopicCell class]) bundle:nil] forCellReuseIdentifier:topicCellID];
}
/**
 添加刷新控件
 */
- (void)setupRefresh{
    self.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    //自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}


#pragma mark - 数据处理
/**
 加载新的帖子数据
 */
- (void)loadNewTopics{
    
    //结束上拉
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.topicType);
    self.params = params;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) {
            return ;
        }
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典转模型
        self.topics = [LSTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        //清空页码
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) {
            return ;
        }
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}
//先下拉刷新,再上拉刷新第5页

//下拉刷新成功回来:只有一页数据,page==0;
//上拉刷新成功回来,最初那一页+第5页

/**
 加载更多帖子数据
 */
- (void)loadMoreTopics{
    //结束下拉
    [self.tableView.mj_header endRefreshing];
    self.page++;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.topicType);
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) {
            return ;
        }
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典转模型
        NSArray *newTopics = [LSTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) {
            return ;
        }
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        //恢复页码
        self.page--;
    }];
    
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count==0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCellID ];
    if (cell == nil) {
        cell = [[LSTopicCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    LSTopic *topic = self.topics[indexPath.row];
    cell.topic =topic;
    
    //    cell.textLabel.text = topic.name;
    //    cell.detailTextLabel.text = topic.text;
    //    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    return cell;
}
#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //取出帖子模型
    LSTopic *topic = self.topics[indexPath.row];
    
    //返回这个模型对应cell高度
    return topic.cellHeight;
}

@end
