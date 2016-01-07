//
//  WYPopoverAnimator.h
//  WYAnimatorDemo
//
//  Created by 王俨 on 15/11/11.
//  Copyright © 2015年 wangyan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WYPopoverAnimatorTypeDown,
    WYPopoverAnimatorTypeBounds,
    WYPopoverAnimatorTypeFateIn // 淡入淡出
}WYPopoverAnimatorType;

@interface WYPopoverAnimator : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

/// model出来的控制器的frame
@property (nonatomic, assign) CGRect presentFrame;
/// 遮罩视图颜色
@property (nonatomic, strong) UIColor *dummyColor;
/// modal出动画的类型
@property (nonatomic, assign) WYPopoverAnimatorType type;
@end
