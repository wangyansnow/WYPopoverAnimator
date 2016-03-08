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
    self.popAnimator.presentFrame = CGRectMake(100, 56, 200, 300);
    // 设置modal的展示样式
    controller.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:controller animated:YES completion:nil];
```
