//
//  WYPopoverAnimator.m
//  WYAnimatorDemo
//
//  Created by 王俨 on 15/11/11.
//  Copyright © 2015年 wangyan. All rights reserved.
//  自定义转场动画类

#import "WYPopoverAnimator.h"
#import "WYPopoverPresentationController.h"

@interface WYPopoverAnimator () 

/// 是否model出控制器的标记
@property (nonatomic, assign) BOOL isPresented;

@end

@implementation WYPopoverAnimator


#pragma mark - UIViewControllerTransitioningDelegate
/// 指定负责 展现 转场动画的对象
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPresented = YES;
    return self;
}
/// 指定负责 消失 转场动画的对象
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresented = NO;
    return self;
}
/// 负责转场动画的控制器
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    WYPopoverPresentationController *popoverVC = [[WYPopoverPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    popoverVC.presentFrame = self.presentFrame;
    popoverVC.dummyColor = self.dummyColor;
    return popoverVC;
}

#pragma mark - UIViewControllerAnimatedTransitioning
/// 转场动画时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}
/// 自定义转场动画
///
/// @param transitionContext 目标控制器(视图), 来源控制器(视图)
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *toView = toVC.view;
    if (self.isPresented) { //需要modal出一个控制器
        [[transitionContext containerView] addSubview:toView];
        
        if (self.type == WYPopoverAnimatorTypeBounds) {
            toView.layer.anchorPoint = CGPointMake(1.0, 1.0);
            toView.transform = CGAffineTransformMakeScale(0.0, 0.0);
            [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
                toView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
        } else if (self.type == WYPopoverAnimatorTypeFateIn) {
            toView.transform = CGAffineTransformMakeScale(0, 0);
            toView.alpha = 0;
            [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:5.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                toView.transform = CGAffineTransformIdentity;
                toView.alpha = 1.0;
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
        } else {
            toView.layer.anchorPoint = CGPointMake(0.5, 0);
            toView.transform = CGAffineTransformMakeScale(1.0, 0);
            [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
                toView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [transitionContext completeTransition:YES];
            }];
        }
        
    } else {    // 取消 modal 出来的控制器
         UIView *modalView = fromVC.view;
        if (self.type == WYPopoverAnimatorTypeBounds) {
            modalView.layer.anchorPoint = CGPointMake(0.8, 1.0);
            [UIView animateWithDuration:0.1 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
                modalView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            } completion:^(BOOL finished) {
                [modalView removeFromSuperview];
                [transitionContext completeTransition:YES];
            }];
        } else if (self.type == WYPopoverAnimatorTypeFateIn) {
            [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:5 options:UIViewAnimationOptionLayoutSubviews animations:^{
                modalView.transform = CGAffineTransformMakeScale(0.001, 0.001);
                modalView.alpha = 0;
            } completion:^(BOOL finished) {
                [modalView removeFromSuperview];
                [transitionContext completeTransition:YES];
            }];
        } else {
            [modalView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }
    }
}
@end










