//
//  LSShowPictureController.m
//  百思不得姐
//
//  Created by chenlishuang on 17/2/7.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSShowPictureController.h"
#import <UIImageView+WebCache.h>
#import "LSTopic.h"
#import <SVProgressHUD.h>
@interface LSShowPictureController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation LSShowPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加图片
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    //屏幕尺寸
//    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
//    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    //图片尺寸
    CGFloat pictureW = kScreenW;
    CGFloat pictureH = pictureW * self.topic.height/self.topic.width;
    if (pictureH>kScreenH) {//图片显示高度超出一个屏幕,需要滚动查看
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }else{
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = kScreenH*0.5;
    }
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
    //将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo1:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo1:(void *)contextInfo{
    if (error) {
        [SVProgressHUD showSuccessWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        
    }
}
@end
