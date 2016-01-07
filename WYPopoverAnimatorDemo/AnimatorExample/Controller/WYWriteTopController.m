//
//  WYWriteTopController.m
//  WYAnimatorDemo
//
//  Created by 王俨 on 15/11/13.
//  Copyright © 2015年 wangyan. All rights reserved.
//

#import "WYWriteTopController.h"
#import "WYTopic.h"
#import "WYTopicCell.h"

#define kTopic @"topic"
@interface WYWriteTopController ()

@property (nonatomic, strong) NSArray *topics;
/// 上次选中的cell
@property (nonatomic, strong) WYTopicCell *selectedCell;

@end

@implementation WYWriteTopController

- (instancetype)initWithIndexPath:(NSIndexPath *)indexPath {
    if (self = [super init]) {
        self.indexPath = indexPath;
        [self.tableView registerClass:[WYTopicCell class] forCellReuseIdentifier:kTopic];
        self.tableView.tableFooterView = [[UIView alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topics = [WYTopic topicsPublish];
    self.view.layer.cornerRadius = 8;
    self.view.clipsToBounds = YES;
    if (self.indexPath) {
        [self selectCell:self.indexPath];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WYTopic *topic = self.topics[indexPath.row];
    WYTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:kTopic];
    cell.topic = topic;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.writeBlock) {
        WYTopic *topic = [self selectCell:indexPath];
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:2];
        [arrM addObject:indexPath];
        if (self.indexPath) {
            [arrM addObject:self.indexPath];
        }
        [tableView reloadRowsAtIndexPaths:arrM withRowAnimation:UITableViewRowAnimationNone];
        self.writeBlock(indexPath, topic);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - private
- (WYTopic *)selectCell:(NSIndexPath *)indexPath {
    WYTopic *lastTopic = self.topics[self.indexPath.row];
    if (self.indexPath.row == indexPath.row) {
        NSLog(@"选中的是一样的");
        lastTopic.selected = YES;
        return lastTopic;
    }
    lastTopic.selected = NO;
    WYTopic *currentTopic = self.topics[indexPath.row];
    currentTopic.selected = YES;
    return currentTopic;
}

@end
