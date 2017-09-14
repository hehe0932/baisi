//
//  LSRecommendController.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/12.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSRecommendController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "LSReconmentCategoryCell.h"
#import <MJExtension.h>
#import "LSRecommendCagetory.h"
#import "LSRecommentUserCell.h"
#import "LSRecommentUser.h"
#import <MJRefresh.h>
@interface LSRecommendController ()<UITableViewDelegate,UITableViewDataSource>
//左边的数据
@property (nonatomic,strong)NSArray *categorys;
//右边的用户数据
//@property (nonatomic,strong)NSArray *users;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
//请求的参数
@property (nonatomic,strong) NSMutableDictionary *params;
//AFN的请求管理者
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@end

@implementation LSRecommendController

static NSString * const categroyID = @"categroy";
static NSString * const userID = @"user";
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //控件的初始化
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
    //加载左侧的类别数据
    [self loadCategories];
}

/**
 加载左侧的类别数据
 */
- (void)loadCategories{
    //发请求
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        LSLog(@"%@",responseObject);
        //隐藏小菊花
        [SVProgressHUD dismiss];
        self.categorys = [LSRecommendCagetory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        //让用户表格进如下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }];

}
- (void)setupTableView{
    self.title = @"推荐关注";
    self.view.backgroundColor = LSGlobaBg;
    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LSReconmentCategoryCell class]) bundle:nil] forCellReuseIdentifier:categroyID];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LSRecommentUserCell class]) bundle:nil] forCellReuseIdentifier:userID];
    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    
}
- (void)setupRefresh{
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
}
#pragma mark---加载用户数据
- (void)loadMoreUsers{
    LSRecommendCagetory *c = self.categorys[self.categoryTableView.indexPathForSelectedRow.row];
    //发送请求给服务器,加载右侧的数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(c.ID);
    parameters[@"page"] = @(++c.currentPage);
    self.params = parameters;
    
    [self.manager  GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典数组->模型数组
        NSArray *users = [LSRecommentUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //添加到当前类别对应的用户数据中
        [c.users addObjectsFromArray:users];
        //不是最后一次请求(block里params还是上一次的params)
        if (self.params != parameters) return ;

        //刷新右边的表格
        [self.userTableView reloadData];
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [self.userTableView.mj_footer endRefreshing];
    }];

}
- (void)loadNewUsers{
    LSRecommendCagetory *c = self.categorys[self.categoryTableView.indexPathForSelectedRow.row];
    //设置当前页码为1
    c.currentPage = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(c.ID);
    params[@"page"] = @(c.currentPage);
    self.params = params;
    
    [self.manager  GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典数组->模型数组
        NSArray *users = [LSRecommentUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //先清除所有旧数据
        [c.users removeAllObjects];
        //添加到当前类别对应的用户数据中
        [c.users addObjectsFromArray:users];
        //保存总数
        c.total = [responseObject[@"total"] integerValue];
        
        //不是最后一次请求(block里params还是上一次的params)
        if (self.params != params) return;
        //刷新右边的表格
        [self.userTableView reloadData];
        
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
        //让底部控件结束刷新
        [self checkFooterState];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LSLog(@"%@",error);
        if (self.params != params) return;
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [self.userTableView.mj_header endRefreshing];
    }];

}

/**
 时刻检测footer的状态
 */
- (void)checkFooterState{
    LSRecommendCagetory *c = self.categorys[self.categoryTableView.indexPathForSelectedRow.row];
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (c.users.count == 0);
    if (c.users.count == c.total) {//全部加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{//还没有加载完毕
        //让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }
}
#pragma mark---UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryTableView) {
        return self.categorys.count;
        
    }else{
        
        //左边被选中的类别模型
        LSRecommendCagetory *c = self.categorys[self.categoryTableView.indexPathForSelectedRow.row];
//        //每次刷新右边数据时, 都控制footer显示或隐藏
//        self.userTableView.mj_footer.hidden = (c.users.count == 0);
        [self checkFooterState];
        return c.users.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTableView) {//左边类别表格
        LSReconmentCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categroyID];
        cell.category = self.categorys[indexPath.row];
        return cell;
    }else{ //右边用户表格
        LSRecommentUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userID];
        LSRecommendCagetory *c = self.categorys[self.categoryTableView.indexPathForSelectedRow.row];
        cell.user = c.users[indexPath.row];

        return cell;
    }
}
#pragma mark---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    if (tableView == self.categoryTableView) {
        LSRecommendCagetory *c = self.categorys[indexPath.row];
        //    [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        if (c.users.count) {
            //显示曾经的数据
            [self.userTableView reloadData];
        } else {
            //赶紧刷新表格,目的是:马上显示当前category的用户数据,不让用户看见上一个残留的数据
            [self.userTableView reloadData];
            
            //发送请求给服务器,加载右侧的数据
            //进入下拉刷新状态 就会调用下拉方法loadNew
            [self.userTableView.mj_header beginRefreshing];
        }
    }
}

#pragma mark - 控制器的销毁

- (void)dealloc{
    //停止所有的操作
    [self.manager.operationQueue cancelAllOperations];
}


@end
