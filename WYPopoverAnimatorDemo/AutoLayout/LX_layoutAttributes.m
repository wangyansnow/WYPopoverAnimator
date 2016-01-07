//
//  LX_layoutAttributes.m
//  LX_LayoutViews
//
//  Copyright © 2015 liweixi. All rights reserved.
//

#import "LX_layoutAttributes.h"

@implementation LX_layoutAttributes

//初始化方法
- (instancetype)init {
    if (self = [super init]) {
        self.horizontal = NSLayoutAttributeLeft;
        self.vertical = NSLayoutAttributeTop;
        self.referHorizontal = NSLayoutAttributeLeft;
        self.referVertical = NSLayoutAttributeTop;
    }
    return self;
}
//添加自定义构造方法
- (instancetype)initWithHorizontal:(NSLayoutAttribute)hor referedHorizontal:(NSLayoutAttribute)refHor AndWithVertical:(NSLayoutAttribute)ver referedVertical:(NSLayoutAttribute)refVer {
    if (self = [super init]) {
        self.horizontal = hor;
        self.referHorizontal = refHor;
        self.vertical = ver;
        self.referVertical = refVer;
    }
    return self;
}

//设置水平和垂直的布局属性
- (instancetype)horizontalAlignmentFrom:(NSLayoutAttribute)fromType To:(NSLayoutAttribute)toType {
    self.horizontal = fromType;
    self.referHorizontal = toType;
    return self;
}

- (instancetype)verticalAlignmentFrom:(NSLayoutAttribute)fromType To:(NSLayoutAttribute)toType {
    self.vertical = fromType;
    self.referVertical = toType;
    return self;
}

@end
