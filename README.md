# WYPopoverAnimator
动画弹窗，方便灵活，达到给控制器瘦身的效果

## 如何使用WYPopoverAnimator
- 手动导入:
    - 将`Animation`整个文件夹拖入到项目中
    - 导入头文件: `#import "WYPopoverAnimator.h"`

## 在代码中如何使用:
```objective-c
/// 转场动画代理
@property (nonatomic, strong) WYPopoverAnimator *popAnimator;

#pragma mark - 懒加载
- (WYPopoverAnimator *)popAnimator {
    if (_popAnimator == nil) {
        _popAnimator = [[WYPopoverAnimator alloc] init];
    }
    return _popAnimator;
}
```

### 在弹出控制器的地方编写代码:
```objective-c
    /// modal出一个新的控制器
    UIViewController *controller = [[UIViewController alloc] init];
    controller.transitioningDelegate = self.popAnimator;
    // 设置弹出控制器的大小
    self.popAnimator.presentFrame = CGRectMake(100, 56, 200, 300);
    // 设置遮罩背景颜色
    self.popAnimator.dummyColor = [UIColor colorWithWhite:0.5 alpha:0.7];
    // 设置动画的类型
    self.popAnimator.type = WYPopoverAnimatorTypeDown;
    // 设置modal的展示样式
    controller.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:controller animated:YES completion:nil];
```

### 具体动画控制样式可参考`WYPopoverAnimator.h`
```objective-c
typedef enum {
    WYPopoverAnimatorTypeDown,   // 由上往下
    WYPopoverAnimatorTypeBounds, // 从中间开始逐渐变到屏幕大小
    WYPopoverAnimatorTypeFateIn  // 淡入淡出
}WYPopoverAnimatorType;

@interface WYPopoverAnimator : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

/// model出来的控制器的frame
@property (nonatomic, assign) CGRect presentFrame;
/// 遮罩视图颜色
@property (nonatomic, strong) UIColor *dummyColor;
/// modal出动画的类型
@property (nonatomic, assign) WYPopoverAnimatorType type;
```
## 动画效果
![image](https://raw.githubusercontent.com/wangyansnow/WYPopoverAnimator/master/snapshot/animation.gif)
