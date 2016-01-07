//
//  WYPopoverPresentationController.m
//  WYAnimatorDemo
//
//  Created by 王俨 on 15/11/11.
//  Copyright © 2015年 wangyan. All rights reserved.
//

#import "WYPopoverPresentationController.h"

@interface WYPopoverPresentationController ()

/// 遮罩
@property (nonatomic, strong) UIView *dummyView;

@end

@implementation WYPopoverPresentationController


/// model控制器转场的控制器
///
/// @param presentedViewController  将要显示的model出来的控制器
/// @param presentingViewController 从哪来的控制器
///
/// @return 控制modal转场动画的控制器
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
    }
    return self;
}

- (void)containerViewWillLayoutSubviews {
    [self setupUI];
    [self presentedView].frame = self.presentFrame;
}

- (void)setupUI {
    self.dummyView.backgroundColor = self.dummyColor;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dummyViewAction:)];
    [self.dummyView addGestureRecognizer:tapGesture];
    [self.containerView insertSubview:self.dummyView atIndex:0];
    self.dummyView.frame = self.containerView.bounds;
}

- (void)dummyViewAction:(UITapGestureRecognizer *)tapGesture {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 懒加载
- (UIView *)dummyView {
    if (_dummyView == nil) {
        _dummyView = [[UIView alloc] init];
    }
    return _dummyView;
}

@end
