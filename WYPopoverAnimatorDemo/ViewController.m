//
//  ViewController.m
//  WYPopoverAnimatorDemo
//
//  Created by 王俨 on 16/1/7.
//  Copyright © 2016年 wangyan. All rights reserved.
//

#import "ViewController.h"
#import "WYTopicButton.h"
#import "WYTopController.h"
#import "WYPopoverAnimator.h"

@interface ViewController ()

/// 转场动画代理
@property (nonatomic, strong) WYPopoverAnimator *popAnimator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WYTopicButton *topBtn = [[WYTopicButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [topBtn setImage:[UIImage imageNamed:@"arrow_topic_filtrate"] forState:UIControlStateNormal];
    [topBtn setTitle:@"话题" forState:UIControlStateNormal];
    [topBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = topBtn;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    UILabel *label;
    label.font = [UIFont boldSystemFontOfSize:18];
}

- (void)topBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    /// modal出一个新的控制器
    WYTopController *topVC = [[WYTopController alloc] init];
    topVC.transitioningDelegate = self.popAnimator;
    self.popAnimator.presentFrame = CGRectMake(100, 56, 200, 300);
    // 设置modal的展示样式
    topVC.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:topVC animated:YES completion:nil];
}

#pragma mark - 懒加载
- (WYPopoverAnimator *)popAnimator {
    if (_popAnimator == nil) {
        _popAnimator = [[WYPopoverAnimator alloc] init];
    }
    return _popAnimator;
}


@end
