//
//  WYWriteStoryController.m
//  WYAnimatorDemo
//
//  Created by 王俨 on 15/11/13.
//  Copyright © 2015年 wangyan. All rights reserved.
//

#import "WYWriteStoryController.h"
#import "UIView+AutoLayoutViews.h"
#import "WYWriteTopController.h"
#import "WYTopic.h"
#import "WYPopoverAnimator.h"

#define kRadius 8
#define kMaxLength 10
#define kMinLength 6
#define APP_WIDTH [UIScreen mainScreen].bounds.size.width
@interface WYWriteStoryController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) UILabel *placeHolderLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIView *selectedView;
@property (weak, nonatomic) IBOutlet UILabel *selectedType;
@property (weak, nonatomic) IBOutlet UIView *topicView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *topicName;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/// 当前选中话题的indexPath
@property (nonatomic, strong) NSIndexPath *indexPath;
/// 转场动画
@property (nonatomic, strong) WYPopoverAnimator *animator;

@end

@implementation WYWriteStoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
#pragma mark - ButtonClick
- (IBAction)cancel {
    NSLog(@"取消");
    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendStory {
    NSLog(@"发送话题");
    if (self.textView.text.length < kMinLength) {
        NSLog(@"您输入的文本太短");
        return;
    }
    NSLog(@"发布成功");
}

- (IBAction)selectedBtnClick {
    WYWriteTopController *writeVC = [[WYWriteTopController alloc] initWithIndexPath:self.indexPath];
    writeVC.writeBlock = ^ (NSIndexPath *indexPath, WYTopic *topic) {
        self.indexPath = indexPath;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.topicView.hidden = NO;
            self.iconView.image = topic.image;
            self.topicName.text = topic.name;
            self.topicName.textColor = topic.color;
            self.imageView.image = topic.image;
            NSUInteger index = random() % topic.content.count;
            self.placeHolderLabel.text = topic.content[index];
        });
    };
    writeVC.transitioningDelegate = self.animator;
    self.animator.presentFrame = CGRectMake(12, 131, (APP_WIDTH - 12 * 2), 132);
    writeVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:writeVC animated:YES completion:nil];
}
#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    self.placeHolderLabel.hidden = textView.hasText;
    self.sendBtn.enabled = textView.hasText;
    
    NSInteger cout = textView.text.length;
    self.tipLabel.text = [NSString stringWithFormat:@"%ld", cout];
    self.tipLabel.textColor = cout < kMaxLength ? [UIColor lightGrayColor] : [UIColor redColor];
}

#pragma mark - preperUI
- (void)setupUI {
    [self preperTextView];
    [self preperSelectView];
    self.topicView.hidden = YES;
}

- (void)preperSelectView {
    self.selectedView.layer.cornerRadius = kRadius;
    self.selectedView.clipsToBounds = YES;
}

- (void)preperTextView {
    self.textView.layer.cornerRadius = kRadius;
    self.textView.clipsToBounds = YES;
    self.textView.contentInset = UIEdgeInsetsMake(kRadius, kRadius, 0, 0);
    self.textView.delegate = self;
    self.textView.alwaysBounceVertical = YES;
    self.textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.textView.contentSize = CGSizeZero;
    
    _placeHolderLabel = [[UILabel alloc] init];
    _placeHolderLabel.text = @"我是占位标签";
    _placeHolderLabel.preferredMaxLayoutWidth = APP_WIDTH - 40;
    _placeHolderLabel.numberOfLines = 0;
    [self.textView addSubview:_placeHolderLabel];
    [_placeHolderLabel lx_InnerLayoutForType:LXLayoutInnerTypeLeftTop referedView:self.textView offset:CGPointMake(kRadius, 4)];
    
//    [self.view sendSubviewToBack:self.textView];
    [self.view bringSubviewToFront:self.countLabel];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
#pragma mark - 懒加载
- (WYPopoverAnimator *)animator {
    if (_animator == nil) {
        _animator = [[WYPopoverAnimator alloc] init];
    }
    return _animator;
}

@end
