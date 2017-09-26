//
//  LSWebViewController.m
//  百思不得姐
//
//  Created by chenlishuang on 2017/9/26.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSWebViewController.h"
#import <NJKWebViewProgress.h>
@interface LSWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
/** 进度代理对象*/
@property (nonatomic,strong)NJKWebViewProgress *progress;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation LSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progress = [[NJKWebViewProgress alloc]init];
    self.webView.delegate = self.progress;
    __weak typeof(self) wSelf = self;
    self.progress.progressBlock = ^(float progress) {
        wSelf.progressView.progress = progress;
        
        wSelf.progressView.hidden = (progress == 1.0);
    };
    self.progress.webViewProxyDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}


- (IBAction)refresh:(id)sender {
    [self.webView reload];
}
- (IBAction)goback:(id)sender {
    [self.webView goBack];
}
- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}


#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.goBackItem.enabled = webView.canGoBack;
    self.goForwardItem.enabled = webView.canGoForward;
}

@end
