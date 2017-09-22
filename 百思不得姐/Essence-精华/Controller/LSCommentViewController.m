//
//  LSCommentViewController.m
//  百思不得姐
//
//  Created by chenlishuang on 2017/9/14.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSCommentViewController.h"
#import "LSTopicCell.h"
#import "LSTopic.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "LSComment.h"
#import <MJExtension.h>
#import "LSCommentHeaderView.h"
#import "LSCommentCell.h"

static NSString *const LSCommentID = @"comment";
@interface LSCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 底部工具条间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 最热评论*/
@property (nonatomic,strong)NSArray *hotComments;
/** 最新评论*/
@property (nonatomic,strong)NSMutableArray *latesComments;
/** 保存帖子的top_cot*/
@property (nonatomic,strong)LSComment *savedTopCmt;
/** 当前的页面*/
@property (nonatomic,assign)NSInteger page;
/** 管理者*/
@property (nonatomic,strong)AFHTTPSessionManager *manager;

@end

@implementation LSCommentViewController
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
    [self setupHeader];
    
    [self setupRefresh];
}

- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.mj_footer.hidden = YES;
}
- (void)loadMoreComments{
    //结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //页码
    NSInteger page = self.page;
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
//    params[@"hot"] = @"1";
    params[@"page"] = @(page);
    LSComment *cmt = self.latesComments.lastObject;
    params[@"lastcid"] = cmt.ID;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"~~%@",responseObject);
        //如果服务器返回的数据不是一个字典,直接返回(解决空评论导致的报错)
        if(![responseObject isKindOfClass:[NSDictionary class]])
        {
            self.tableView.mj_header.hidden = YES;
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        //最新评论
        NSArray *newComments = [LSComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latesComments addObjectsFromArray:newComments];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latesComments.count >= total) {//全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        
        self.page = page;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
- (void)loadNewComments{
    //结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"~~%@",responseObject);

        self.page = 1;
        //最热评论
        self.hotComments = [LSComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        //最新评论
        self.latesComments = [LSComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latesComments.count >= total) {//全部加载完毕
            
            self.tableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)setupHeader{
    UIView *header = [[UIView alloc]init];
    
    //清空top_cmt
    if (self.topic.top_cmt) {
        self.savedTopCmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
    LSTopicCell *cell = [LSTopicCell cell];
    cell.topic = self.topic;
    cell.height = self.topic.cellHeight;
    [header addSubview:cell];
    header.height = self.topic.cellHeight + topicCellMargin;
    cell.size = CGSizeMake(ScreenW, self.topic.cellHeight);
//    cell.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.tableView.tableHeaderView = header;
}
- (void)setupBasic{

    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //cell的高度设置
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = LSGlobaBg;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LSCommentCell class]) bundle:nil] forCellReuseIdentifier:LSCommentID];
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, topicCellMargin, 0);
}

- (void)keyboardWillChangeFrame:(NSNotification *)noti {
    //键盘显示/隐藏完毕的frame
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomSpace.constant = ScreenH - frame.origin.y;
    //动画时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    //恢复帖子的top_cmt
    if (self.savedTopCmt) {
        self.topic.top_cmt = self.savedTopCmt;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    //取消所有任务
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager invalidateSessionCancelingTasks:YES];//比上面搞得更彻底
}

/**
 返回第section组的所有评论数组
 */
- (NSArray *)commentsinSecion:(NSInteger)secion{
    if (secion == 0) {
        return self.hotComments.count?self.hotComments:self.latesComments;
    }
    return self.latesComments;
}

- (LSComment *)commentInIndexPath:(NSIndexPath *)indexPath{
   return [self commentsinSecion:indexPath.section][indexPath.row];
}
#pragma mark - UITableViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self.view endEditing:YES];
    [[UIMenuController sharedMenuController]setMenuVisible:NO animated:NO];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latesCount = self.latesComments.count;
    if (hotCount) return 2;//最热评论 + 最新评论
    if (latesCount)return 1;//只有最新评论
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger hotCount = self.hotComments.count;
    NSInteger latesCount = self.latesComments.count;
    //隐藏尾部控件
    tableView.mj_footer.hidden = (latesCount == 0);
    
    if (section == 0) {
        return hotCount ? hotCount:latesCount;
    }
    if (section == 1) return latesCount;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LSCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:LSCommentID];
    if (!cell) {
        cell = [[LSCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LSCommentID];
    }
    LSComment *comment = [self commentInIndexPath:indexPath];
    cell.comment = comment;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //被点击的cell
    LSCommentCell *cell = (LSCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
    //出现第一响应者
    [cell becomeFirstResponder];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
        
    }else{
        
        CGRect rect = CGRectMake(0, cell.height *0.5, cell.width, cell.height * 0.5);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
        
        UIMenuItem *dingItem = [[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replayItem = [[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *reportItem = [[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(report:)];
        menu.menuItems = @[dingItem,replayItem,reportItem];
    }
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        return hotCount ? @"最热评论":@"最新评论";
//    }
//    return @"最新评论";
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    static NSString *ID = @"header";
//    //先从缓存池中找header
//    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
//    UILabel *label = nil;
//    if (header == nil) {
//        header = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:ID];
//        header.contentView.backgroundColor = LSGlobaBg;
//        //创建内容
//        label = [[UILabel alloc]init];
//        label.textColor = LSRGBColor(67, 67, 67);
//        label.width = 200;
//        label.x = topicCellMargin;
//        label.tag = LSHeaderLabelTag;
//        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        [header.contentView addSubview:label];
//    }else{//从缓存池取出来的
//        label = (UILabel *)[header viewWithTag:LSHeaderLabelTag];
//    }
//   //设置label的数据
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        label.text = hotCount ? @"最热评论":@"最新评论";
//    }else{
//        label.text = @"最新评论";
//    }
//    return header;
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *ID = @"header";
    //先从缓存池中找header
    LSCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[LSCommentHeaderView alloc]initWithReuseIdentifier:ID];
        
    }
    //设置label的数据
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title = hotCount ? @"最热评论":@"最新评论";
    }else{
        header.title = @"最新评论";
    }
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}
#pragma mark - MenuController的处理


- (void)ding:(UIMenuController *)sender{
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    NSLog(@"%zd - %zd",indexPath.section ,indexPath.row);
}

- (void)replay:(UIMenuController *)sender{
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    NSLog(@"%zd - %zd",indexPath.section ,indexPath.row);
}
- (void)report:(UIMenuController *)sender{
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    NSLog(@"%zd - %zd",indexPath.section ,indexPath.row);
}

@end
