//
//  LX_layoutAttributes.h
//  LX_LayoutViews
//
//  Copyright © 2015 liweixi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LX_layoutAttributes : NSObject

@property (nonatomic,assign) NSLayoutAttribute horizontal;
@property (nonatomic,assign) NSLayoutAttribute vertical;
@property (nonatomic,assign) NSLayoutAttribute referHorizontal;
@property (nonatomic,assign) NSLayoutAttribute referVertical;

- (instancetype)initWithHorizontal:(NSLayoutAttribute)hor referedHorizontal:(NSLayoutAttribute)refHor AndWithVertical:(NSLayoutAttribute)ver referedVertical:(NSLayoutAttribute)refVer;

- (instancetype)horizontalAlignmentFrom:(NSLayoutAttribute)fromType To:(NSLayoutAttribute)toType;
- (instancetype)verticalAlignmentFrom:(NSLayoutAttribute)fromType To:(NSLayoutAttribute)toType;

@end
