//
//  WYTopic.m
//  WYAnimatorDemo
//
//  Created by 王俨 on 15/11/11.
//  Copyright © 2015年 wangyan. All rights reserved.
//

#import "WYTopic.h"

@implementation WYTopic

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)topicWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.topic_id = [value integerValue];
        return;
    } else if ([key isEqualToString:@"image_url"]) {
        self.image = [UIImage imageWithData:value];
        return;
    }
    [super setValue:value forKey:key];
}

/// 获取筛选的话题
+ (NSArray *)topicsFilter:(CategoryBlock)category {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"story.plist" ofType:nil];
    NSMutableArray *arrayM = [NSMutableArray array];
    
    WYTopic *topic = [[WYTopic alloc] init];
    topic.image = [UIImage imageNamed:@"icon_topic_filtrate_all"];
    topic.color = [UIColor colorWithRed:54/255.0 green:145/255.0 blue:255/255.0 alpha:1.0];
    topic.name = @"全部";
    topic.topic_id = 0;
    
    NSNumber *number = [NSNumber numberWithBool:NO];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    [dictM setObject:number forKey:topic.idstr];
    [arrayM addObject:topic];
    
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *dict in arr) {
        WYTopic *topic = [WYTopic topicWithDict:dict];
        if (topic.popular_filter) {
            [arrayM addObject:topic];
            [dictM setObject:number forKey:topic.idstr];
        }
    }
    WYTopic *myTop = [[WYTopic alloc] init];
    myTop.image = [UIImage imageNamed:@"icon_topic_filtrate_my"];
    myTop.color = [UIColor orangeColor];
    myTop.topic_id = -1;
    myTop.name = @"我发布的";
    
    [arrayM addObject:myTop];
    [dictM setObject:number forKey:topic.idstr];
    category(dictM);
    return arrayM.copy;
}

/// 发布的话题
+ (NSArray *)topicsPublish {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"story.plist" ofType:nil];
    NSMutableArray *arrayM = [NSMutableArray array];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *dict in arr) {
        WYTopic *topic = [WYTopic topicWithDict:dict];
        if (topic.valid) {
            [arrayM addObject:topic];
        }
    }
    return arrayM.copy;
}

- (UIColor *)color {
    if (_color == nil) {
        _color = [UIColor colorWithRed:self.color_rgb_r.floatValue/255.0 green:self.color_rgb_g.floatValue/255.0 blue:self.color_rgb_b.floatValue/255.0 alpha:1.0];
    }
    return _color;
}
- (NSString *)idstr {
    if (_idstr == nil) {
        _idstr = [NSString stringWithFormat:@"%ld", self.topic_id];
    }
    return _idstr;
}

@end
