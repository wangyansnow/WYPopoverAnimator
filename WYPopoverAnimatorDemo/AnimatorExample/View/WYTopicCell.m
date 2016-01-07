//
//  WYTopicCell.m
//  WYAnimatorDemo
//
//  Created by 王俨 on 15/11/11.
//  Copyright © 2015年 wangyan. All rights reserved.
//

#import "WYTopicCell.h"
#import "UIView+AutoLayoutViews.h"

@interface WYTopicCell ()

@property (nonatomic, strong) UIImageView *topicIcon;
@property (nonatomic, strong) UILabel *nameLabel;
/// 对钩
@property (nonatomic, strong) UIImageView *hookIcon;

@end

@implementation WYTopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setTopic:(WYTopic *)topic {
    _topic = topic;
    self.topicIcon.image = topic.image;
    self.nameLabel.text = topic.name;
    self.nameLabel.textColor = topic.color;
    self.hookIcon.hidden = !topic.isSelected;
}
/// icon_topic_type_opt
- (void)setupUI {
    _topicIcon = [[UIImageView alloc] init];
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont boldSystemFontOfSize:14.0];
    _hookIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_topic_type_opt"]];
    
    [self.contentView addSubview:_topicIcon];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_hookIcon];
    
    [_topicIcon lx_InnerLayoutForType:LXLayoutInnerTypeLeftTop referedView:self.contentView size:CGSizeMake(22, 22) offset:CGPointMake(7, 11)];
    [_nameLabel lx_OuterLayoutForType:LXLayoutOuterTypeRightCenter referedView:_topicIcon offset:CGPointMake(5, 0)];
    [_hookIcon lx_InnerLayoutForType:LXLayoutInnerTypeRightCenter referedView:self.contentView size:CGSizeZero offset:CGPointMake(-5, 0)];
}

@end
