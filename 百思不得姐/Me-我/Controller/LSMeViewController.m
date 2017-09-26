//
//  LSMeViewController.m
//  百思不得姐
//
//  Created by chenlishuang on 17/1/11.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSMeViewController.h"
#import "LSMeCell.h"
#import "LSMeFooterView.h"
@interface LSMeViewController ()

@end

@implementation LSMeViewController

static NSString *meID = @"meID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
    
    

}
- (void)configTableView{
    self.navigationItem.title = @"我的";
    //导航栏右边按钮
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingButtonAction)],[UIBarButtonItem itemWithImage:@"mine-sun-icon" highImage:@"mine-sun-icon-click" target:self action:@selector(nightButtonAction)]];
    self.tableView.backgroundColor = LSGlobaBg;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[LSMeCell class] forCellReuseIdentifier:meID];
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = topicCellMargin;
    
    //设置footerView
    self.tableView.tableFooterView = [[LSMeFooterView alloc]init];
}
- (void)settingButtonAction {
    
}

- (void)nightButtonAction {
    
}



#pragma mark - 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LSMeCell *cell = [tableView dequeueReusableCellWithIdentifier:meID];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}



@end
