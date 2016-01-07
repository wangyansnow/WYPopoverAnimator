//
//  WYTopController.m
//  WYAnimatorDemo
//
//  Created by 王俨 on 15/11/11.
//  Copyright © 2015年 wangyan. All rights reserved.
//

#import "WYTopController.h"
#import "WYTopic.h"
#import "WYTopicCell.h"

#define kReuseId @"topic"

@interface WYTopController () <UITableViewDataSource, UITableViewDelegate>
/// 背景图片
@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *filterLabel;
@property (nonatomic, strong) UIView *divideView;

/// 话题数组(tableView dataSource)
@property (nonatomic, strong) NSArray *topics;

@end

@implementation WYTopController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.topics = [WYTopic topicsPublish];
    NSLog(@"topics = %@", self.topics);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYTopic *topic = self.topics[indexPath.row];
    WYTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseId];
    if (cell == nil) {
        cell = [[WYTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kReuseId];
    }
    cell.topic = topic;
    return cell;
}

#pragma mark -UITableViewDelegate

- (void)setupUI {
    _backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tankuang"]];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _filterLabel = [[UILabel alloc] init];
    _filterLabel.text = @"筛选";
    _filterLabel.font = [UIFont boldSystemFontOfSize:15.0];
    [_filterLabel sizeToFit];
    
    _divideView = [[UIView alloc] init];
    _divideView.backgroundColor = [UIColor redColor];
    
    
    [self.view addSubview:_backView];
    [self.view addSubview:_tableView];
    [self.view addSubview:_filterLabel];
    [self.view addSubview:_divideView];
    
    // 自动布局
    _backView.translatesAutoresizingMaskIntoConstraints = false;
    _tableView.translatesAutoresizingMaskIntoConstraints = false;
    _filterLabel.translatesAutoresizingMaskIntoConstraints = false;
    _divideView.translatesAutoresizingMaskIntoConstraints = false;
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[subView]-0-|" options:0 metrics:nil views:@{@"subView": _backView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[subView]-0-|" options:0 metrics:nil views:@{@"subView": _backView}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[subView]-10-|" options:0 metrics:nil views:@{@"subView": _tableView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-44-[subView]-20-|" options:0 metrics:nil views:@{@"subView": _tableView}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[subView]" options:0 metrics:nil views:@{@"subView": _filterLabel}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-18-[subView]" options:0 metrics:nil views:@{@"subView": _filterLabel}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-4-[subView]-4-|" options:0 metrics:nil views:@{@"subView": _divideView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-44-[subView(0.5)]" options:0 metrics:nil views:@{@"subView": _divideView}]];
}
@end






