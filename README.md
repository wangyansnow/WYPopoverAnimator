# WYPopoverAnimator
动画弹窗，方便灵活，达到给控制器瘦身的效果

只需要把项目中的Animator整个文件夹拖到项目中即可。

使用方式：
1.设置为控制器的属性【使用懒加载的方式】
@property (nonatomic, strong) WYStoryAnimator *animator;

2.在需要弹出动画的地方，设置要弹出的控制器的代理为animator
UIViewController *writeVC = [UIViewController new];
    writeVC.transitioningDelegate = self.animator;
    self.animator.presentFrame = CGRectMake(12, 131, (APP_WIDTH - 12 * 2), 132);
    writeVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:writeVC animated:YES completion:nil];
