//
//  LSPostWordViewController.m
//  百思不得姐
//
//  Created by chenlishuang on 2017/9/26.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSPostWordViewController.h"
#import "LSPlacehoderTextView.h"
#import "LSAddTagToolBar.h"
@interface LSPostWordViewController ()<UITextViewDelegate>
/** 文本输入控件*/
@property (nonatomic,weak)LSPlacehoderTextView *textView;
/** 工具条*/
@property (nonatomic,weak)LSAddTagToolBar *toolbar;
@end

@implementation LSPostWordViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
    
    [self setupToolbar];
}
////
//- (void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//}
- (void)setupToolbar{
    LSAddTagToolBar *toolbar = [LSAddTagToolBar viewFromXib];
    toolbar.width = self.view.width;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    
    self.toolbar = toolbar;
    
    [LSNoteCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)noti{
    //键盘最终的frame
    CGRect keyboardF = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //动画时间
//    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
//    [UIView animateWithDuration:duration animations:^{
    
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, keyboardF.origin.y-ScreenH);
//    }];
}
- (void)setupTextView{
    LSPlacehoderTextView *textView = [[LSPlacehoderTextView alloc]init];
    textView.delegate = self;
    textView.frame = self.view.bounds;
    textView.placeholder = @"把好玩的图片,好笑的段子或者糗事发到这里,接受千万网友膜拜吧,发布违反国家法律内容的,我们将依法提交有关部门处理.";
//    textView.inputAccessoryView = [LSAddTagToolBar viewFromXib];
    [self.view addSubview:textView];
    
    self.textView = textView;
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

#pragma mark - <UITextViewDelegate>

- (void)textViewDidChange:(UITextView *)textView{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
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
