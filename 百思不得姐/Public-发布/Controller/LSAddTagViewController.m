//
//  LSAddTagViewController.m
//  百思不得姐
//
//  Created by chenlishuang on 2017/9/27.
//  Copyright © 2017年 chenlishuang. All rights reserved.
//

#import "LSAddTagViewController.h"
#import "LSTagButton.h"
@interface LSAddTagViewController ()
/** 内容*/
@property (nonatomic,weak)UIView *contentView;
/** 文本输入框 */
@property (nonatomic,weak)UITextField *textField;
/** 添加按钮*/
@property (nonatomic,weak)UIButton *addButton;
/** 所有的标签按钮*/
@property (nonatomic,strong)NSMutableArray *tagButtons;

@end

@implementation LSAddTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupContentView];
    [self setupTextField];
}
- (void)setupNav{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    
}

- (void)setupContentView{
    UIView *contentView = [[UIView alloc]init];
    contentView.x = LSTagMargin;
    contentView.width = self.view.width - 2*contentView.x;
    contentView.y = LSTagMargin + 64;
    contentView.height = ScreenH;
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

- (void)setupTextField{
    UITextField *textField = [[UITextField alloc]init];
    textField.width = ScreenW;
    textField.height = 25;
    [textField becomeFirstResponder];
    textField.placeholder = @"多个标签用逗号或换行隔开";
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:textField];
    
    self.textField = textField;
}


- (void)done {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//监听文字改变
- (void)textDidChange{
    
    if (self.textField.hasText) {
        //显示添加标签的按钮
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + LSTagMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签:%@",self.textField.text] forState:UIControlStateNormal];
        
    }else{
        self.addButton.hidden = YES;
    }
    //更新标签和文本框的内容
    [self updatetagButtonFrame];
}

/**
 监听加号按钮点击
 */
- (void)addButtonClick{
    
    //添加一个标签按钮
    LSTagButton *tagButton = [LSTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [tagButton addTarget:self action:@selector(addTagButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    [tagButton sizeToFit];//放在button的setTitle方法里
    tagButton.height = self.textField.height;
    
    [self.contentView addSubview:tagButton];
    
    [self.tagButtons addObject:tagButton];
    //更新标签按钮的frame
    [self updatetagButtonFrame];
    
    //清空textfield文字
    self.textField.text = nil;
    self.addButton.hidden = YES;
}
//更新标签按钮的frame
- (void)updatetagButtonFrame{
    for (int i = 0; i < self.tagButtons.count; i++) {
        LSTagButton *tagButton = self.tagButtons[i];
        if (i == 0) {//最前面的标签按钮
            tagButton.x = 0;
            tagButton.y = 0;
        }else{//其他的
            LSTagButton *lastTagButton = self.tagButtons[i-1];
            //当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + LSTagMargin;
            //计算当前行右边的宽度
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth >= tagButton.width) {//按钮显示当前行
                tagButton.y = lastTagButton.y;
                tagButton.x = leftWidth;
            }else{ //按钮显示在下一行
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + LSTagMargin;
            }
        }
    }
    
    //最后一个标签按钮
    LSTagButton *lastTagButton = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + LSTagMargin;
    //更新textfield的frame
    if (self.contentView.width - leftWidth >= [self textFieldWidth]) {
        self.textField.y = lastTagButton.y;
        self.textField.x = leftWidth;
    }else{
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagButton.frame) + LSTagMargin;
    }
}

/**
 textField的文字宽度
 */
- (CGFloat)textFieldWidth{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(100, textW);
}
- (void)addTagButton:(UIButton *)tagButton{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    //重新更新所有标签按钮的frame
    [UIView animateWithDuration:.25 animations:^{
        
        [self updatetagButtonFrame];
    }];
}
- (UIButton *)addButton{
    if (!_addButton) {
       UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.width = self.contentView.width;
        addButton.height = 35;
        addButton.backgroundColor = LSTagBG;
        addButton.titleLabel.font = [UIFont systemFontOfSize:14];
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, LSTagMargin, 0, LSTagMargin);
        //让按钮内部的文字和图片左对齐
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:addButton];
        _addButton = addButton;
    }
    return _addButton;
}

- (NSMutableArray *)tagButtons{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}
@end
