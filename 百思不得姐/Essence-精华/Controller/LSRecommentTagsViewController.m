//
//  LSRecommentTagsViewController.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/16.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSRecommentTagsViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "LSRecommendTag.h"
#import "LSRecommentTagCell.h"
@interface LSRecommentTagsViewController ()

@property (nonatomic,strong)NSArray *tags;
@end
static NSString *const tagsID = @"tag";
@implementation LSRecommentTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self loadTags];
    
}

- (void)setupTableView {
    self.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LSRecommentTagCell class]) bundle:nil] forCellReuseIdentifier:tagsID];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = LSGlobaBg;
}
- (void)loadTags{
    //发请求
    [SVProgressHUD show];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"c"] = @"sub";
    params[@"c"] = @"topic";
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.tags = [LSRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSRecommentTagCell *cell = [tableView dequeueReusableCellWithIdentifier:tagsID ];
    cell.recommendTag = self.tags[indexPath.row];
    return cell;
}



@end
