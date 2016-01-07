//
//  UIView+AutoLayoutViews.h
//  LX_LayoutViews
//
//  Copyright © 2015 liweixi. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,LXLayoutInnerType) {
    LXLayoutInnerTypeLeftTop = 1,
    LXLayoutInnerTypeLeftCenter,
    LXLayoutInnerTypeLeftBottom,
    
    LXLayoutInnerTypeCenterTop,
    LXLayoutInnerTypeCenter,
    LXLayoutInnerTypeCenterBottom,
    
    LXLayoutInnerTypeRightTop,
    LXLayoutInnerTypeRightCenter,
    LXLayoutInnerTypeRightBottom
};

typedef NS_ENUM(NSInteger,LXLayoutOuterType) {
    LXLayoutOuterTypeTopLeft = 1,
    LXLayoutOuterTypeTopCenter,
    LXLayoutOuterTypeTopRight,
    
    LXLayoutOuterTypeBottomLeft,
    LXLayoutOuterTypeBottomCenter,
    LXLayoutOuterTypeBottomRight,
    
    
    LXLayoutOuterTypeLeftTop,
    LXLayoutOuterTypeLeftCenter,
    LXLayoutOuterTypeLeftBottom,
    
    LXLayoutOuterTypeRightTop,
    LXLayoutOuterTypeRightCenter,
    LXLayoutOuterTypeRightBottom
};

typedef NS_ENUM(NSInteger,LXLayoutTileDirection) {
    LXLayoutTileDirectionHorizontal = 0,
    LXLayoutTileDirectionVertical
};

@interface UIView (AutoLayoutViews)
//外部接口

- (NSArray *)lx_InnerLayoutForType:(LXLayoutInnerType)type referedView:(UIView *)refView offset:(CGPoint)offset;
- (NSArray *)lx_InnerLayoutForType:(LXLayoutInnerType)type referedView:(UIView *)refView size:(CGSize)size offset:(CGPoint)offset;

- (NSArray *)lx_OuterLayoutForType:(LXLayoutOuterType)type referedView:(UIView *)refView offset:(CGPoint)offset;
- (NSArray *)lx_OuterLayoutForType:(LXLayoutOuterType)type referedView:(UIView *)refView size:(CGSize)size offset:(CGPoint)offset;

- (NSArray *)lx_fillView:(UIView *)refView inset:(UIEdgeInsets)inset;

- (NSArray *)lx_tileViews:(NSArray *)views Direction:(LXLayoutTileDirection)direction Inset:(UIEdgeInsets)inset;
- (NSLayoutConstraint *)lx_constraintInConstraintsList:(NSArray *)conList attribute:(NSLayoutAttribute)attribute;

- (NSArray *)lx_sizeLayout:(CGSize)size;


@end


