//
//  LSPostWordViewController.m
//  百思不得姐
//
//  Created by chenlishuang on 2017/9/26.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSPostWordViewController.h"
#import "LSPlacehoderTextView.h"
@interface LSPostWordViewController ()

@end

@implementation LSPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
}

- (void)setupTextView{
    LSPlacehoderTextView *textView = [[LSPlacehoderTextView alloc]init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"把好玩的图片,好笑的段子或者糗事发到这里,接受千万网友膜拜吧,发布违反国家法律内容的,我们将依法提交有关部门处理.";
    [self.view addSubview:textView];
}

- (void)setupNav{
    self.title = @"发表文字";
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
}
- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post{

}
/**
 UITextField
 1.只能显示一行文字
 2.有占位文字
 
 UITextView
 1.能显示任意行
 2.没有占位文字
 
 */

@end
