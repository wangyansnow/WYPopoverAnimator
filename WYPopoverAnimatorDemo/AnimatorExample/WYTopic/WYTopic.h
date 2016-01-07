//
//  WYTopic.h
//  WYAnimatorDemo
//
//  Created by 王俨 on 15/11/11.
//  Copyright © 2015年 wangyan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CategoryBlock)(NSMutableDictionary *category_dict);

@interface WYTopic : UIViewController

/// 话题ID
@property (nonatomic, assign) NSInteger topic_id;
/// 话题ID的字符串
@property (nonatomic, copy) NSString *idstr;

/// 话题的 RGB(0~255)
@property (nonatomic, copy) NSString *color_rgb_r;
@property (nonatomic, copy) NSString *color_rgb_g;
@property (nonatomic, copy) NSString *color_rgb_b;
/// 话题的颜色
@property (nonatomic, strong) UIColor *color;

/// 话题图标
@property (nonatomic, strong) UIImage *image;
/// 话题名称
@property (nonatomic, copy) NSString *name;
/// 是否出现在过滤
@property (nonatomic, assign) BOOL popular_filter;
/// 是否出现在发布
@property (nonatomic, assign) BOOL valid;

/// 话题是否被选中
@property (nonatomic, assign, getter=isSelected) BOOL selected;
/// 话题内容数组
@property (nonatomic, strong) NSArray *content;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)topicWithDict:(NSDictionary *)dict;

/// 获取筛选的话题
+ (NSArray *)topicsFilter:(CategoryBlock)category;
/// 发布的话题
+ (NSArray *)topicsPublish;

@end
