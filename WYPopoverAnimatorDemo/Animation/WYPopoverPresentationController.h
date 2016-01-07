//
//  WYPopoverPresentationController.h
//  WYAnimatorDemo
//
//  Created by 王俨 on 15/11/11.
//  Copyright © 2015年 wangyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYPopoverPresentationController : UIPresentationController

/// model 出来的控制器的view的大小
@property (nonatomic, assign) CGRect presentFrame;
/// 遮罩视图颜色
@property (nonatomic, strong) UIColor *dummyColor;
@end
