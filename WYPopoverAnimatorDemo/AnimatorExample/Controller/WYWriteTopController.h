//
//  WYWriteTopController.h
//  WYAnimatorDemo
//
//  Created by 王俨 on 15/11/13.
//  Copyright © 2015年 wangyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYTopic;
typedef void(^WriteBlock)(NSIndexPath *indexPath, WYTopic *topic);
@interface WYWriteTopController : UITableViewController

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) WriteBlock writeBlock;

- (instancetype)initWithIndexPath:(NSIndexPath *)indexPath;

@end
