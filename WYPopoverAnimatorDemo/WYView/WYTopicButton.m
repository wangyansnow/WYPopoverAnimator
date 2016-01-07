//
//  WYTopicButton.m
//  nightChat
//
//  Created by 王俨 on 15/11/10.
//  Copyright © 2015年 nightGroup. All rights reserved.
//

#import "WYTopicButton.h"
#import "UIView+Extension.h"

@implementation WYTopicButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.x = (self.width - self.titleLabel.width - self.imageView.width) * 0.5;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 2;
    self.titleLabel.y = (self.height - self.titleLabel.height) * 0.5;
    self.imageView.y = (self.height - self.imageView.height) * 0.5;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI);
}

@end
