//
//  LSCommentViewController.m
//  百思不得姐
//
//  Created by chenlishuang on 2017/9/14.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSCommentViewController.h"

@interface LSCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 底部工具条间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LSCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
}

- (void)setupBasic{

    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.tableView.delegate = self;
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
}

#pragma mark - UITableViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
@end
