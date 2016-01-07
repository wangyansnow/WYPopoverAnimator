//
//  UIView+AutoLayoutViews.m
//  LX_LayoutViews
//
//  Copyright © 2015 liweixi. All rights reserved.
//

#import "UIView+AutoLayoutViews.h"
#import "LX_layoutAttributes.h"

@implementation UIView (AutoLayoutViews)


#pragma mark - 外部调用函数
/// 参照视图内部布局
///
/// @param type   : 对齐方式
/// @param refView: 参照视图
/// @param size   : 设定大小
/// @param offset : 设定偏移
///
/// @return 约束数组
- (NSArray *)lx_InnerLayoutForType:(LXLayoutInnerType)type referedView:(UIView *)refView size:(CGSize)size offset:(CGPoint)offset {
    NSAssert(refView, @"参照视图不可为空");
    LX_layoutAttributes *attributes = [self innerLayoutAttributesForType:type];
    return [self lx_layoutWithAttributes:attributes referedView:refView size:size offset:offset];
    
    
}
- (NSArray *)lx_InnerLayoutForType:(LXLayoutInnerType)type referedView:(UIView *)refView offset:(CGPoint)offset {
    NSAssert(refView, @"参照视图不可为空");
    LX_layoutAttributes *attributes = [self innerLayoutAttributesForType:type];
    return [self lx_layoutWithAttributes:attributes referedView:refView size:CGSizeZero offset:offset];
}

/// 参照视图外部布局
///
/// @param type   : 对齐方式
/// @param refView: 参照视图
/// @param size   : 设定大小
/// @param offset : 设定偏移
///
/// @return 约束数组
- (NSArray *)lx_OuterLayoutForType:(LXLayoutOuterType)type referedView:(UIView *)refView size:(CGSize)size offset:(CGPoint)offset {
    NSAssert(refView, @"参照视图不可为空");
    LX_layoutAttributes *attributes = [self outerLayoutAttributesForType:type];
    return [self lx_layoutWithAttributes:attributes referedView:refView size:size offset:offset];
}
- (NSArray *)lx_OuterLayoutForType:(LXLayoutOuterType)type referedView:(UIView *)refView offset:(CGPoint)offset {
    NSAssert(refView, @"参照视图不可为空");
    LX_layoutAttributes *attributes = [self outerLayoutAttributesForType:type];
    return [self lx_layoutWithAttributes:attributes referedView:refView size:CGSizeZero offset:offset];
}

/// 子视图填充
///
/// @param refView: 参照视图
/// @param inset  : 间距
///
/// @return <#return value description#>
- (NSArray *)lx_fillView:(UIView *)refView inset:(UIEdgeInsets)inset {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSMutableArray *cons = [NSMutableArray array];
    
    NSString *horizontalConStr = [NSString stringWithFormat:@"H:|-%f-[subview]-%f-|",inset.left,inset.right];
    NSString *verticalConStr = [NSString stringWithFormat:@"V:|-%f-[subview]-%f-|",inset.top,inset.bottom];

    [cons addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:horizontalConStr options:NSLayoutFormatAlignAllBaseline metrics:nil views:@{@"subview":self}]];
    [cons addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:verticalConStr options:NSLayoutFormatAlignAllBaseline metrics:nil views:@{@"subview":self}]];
    [self.superview addConstraints:cons.copy];
    
    return cons.copy;
}

/// 父视图平铺
///
/// @param views    : 子视图数组
/// @param direction: 平铺方向
/// @param inset    : 间距
///
/// @return 约束数组
- (NSArray *)lx_tileViews:(NSArray *)views Direction:(LXLayoutTileDirection)direction Inset:(UIEdgeInsets)inset {
    NSAssert((views || views.count != 0), @"布局子视图不存在！");
    return [self lx_tileLayout:views Direction:direction Inset:inset];
}

/**
 *  获取指定约束
 *
 *  @param conList  : 约束数组
 *  @param attribute: 指定约束属性
 *
 *  @return 对应约束
 */
- (NSLayoutConstraint *)lx_constraintInConstraintsList:(NSArray *)conList attribute:(NSLayoutAttribute)attribute {
    for (NSLayoutConstraint *constraint in conList) {
        
        if ((UIView *)constraint.firstItem == self && constraint.firstAttribute == attribute) {
            return constraint;
        }
    }
    return nil;
    
}

/// 设置大小
///
/// @param size: 参照的大小
///
/// @return 约束数组
- (NSArray *)lx_sizeLayout:(CGSize)size {
    NSLayoutConstraint *conW = [self lx_constraintInConstraintsList:self.superview.constraints attribute:NSLayoutAttributeWidth];
    if (conW) {
        [self.superview removeConstraint:conW];
    }
    
    NSLayoutConstraint *conH = [self lx_constraintInConstraintsList:self.superview.constraints attribute:NSLayoutAttributeHeight];
    if (conH) {
        [self.superview removeConstraint:conH];
    }
    
    NSArray *newsizeCons = [self lx_sizeConstraints:size];
    [self.superview addConstraints:newsizeCons];
    return newsizeCons;
}

#pragma mark - 内部私有函数
- (LX_layoutAttributes *)outerLayoutAttributesForType:(LXLayoutOuterType)type {
    LX_layoutAttributes *attribute = [[LX_layoutAttributes alloc]init];
    switch (type) {
        case LXLayoutOuterTypeTopLeft:
            attribute = [[LX_layoutAttributes alloc] initWithHorizontal:NSLayoutAttributeLeft referedHorizontal:NSLayoutAttributeLeft AndWithVertical:NSLayoutAttributeBottom referedVertical:NSLayoutAttributeTop];
            break;
        case LXLayoutOuterTypeTopCenter:
            attribute = [[LX_layoutAttributes alloc] initWithHorizontal:NSLayoutAttributeCenterX referedHorizontal:NSLayoutAttributeCenterX AndWithVertical:NSLayoutAttributeBottom referedVertical:NSLayoutAttributeTop];
            break;
        case LXLayoutOuterTypeTopRight:
            attribute = [[LX_layoutAttributes alloc] initWithHorizontal:NSLayoutAttributeRight referedHorizontal:NSLayoutAttributeRight AndWithVertical:NSLayoutAttributeBottom referedVertical:NSLayoutAttributeTop];
            break;
            
        case LXLayoutOuterTypeBottomLeft:
            attribute = [[LX_layoutAttributes alloc] initWithHorizontal:NSLayoutAttributeLeft referedHorizontal:NSLayoutAttributeLeft AndWithVertical:NSLayoutAttributeTop referedVertical:NSLayoutAttributeBottom];
            break;
        case LXLayoutOuterTypeBottomCenter:
            attribute = [[LX_layoutAttributes alloc] initWithHorizontal:NSLayoutAttributeCenterX referedHorizontal:NSLayoutAttributeCenterX AndWithVertical:NSLayoutAttributeTop referedVertical:NSLayoutAttributeBottom];
            break;
        case LXLayoutOuterTypeBottomRight:
            attribute = [[LX_layoutAttributes alloc] initWithHorizontal:NSLayoutAttributeRight referedHorizontal:NSLayoutAttributeRight AndWithVertical:NSLayoutAttributeTop referedVertical:NSLayoutAttributeBottom];
            break;
            
        case LXLayoutOuterTypeLeftTop:
            attribute = [[LX_layoutAttributes alloc] initWithHorizontal:NSLayoutAttributeRight referedHorizontal:NSLayoutAttributeLeft AndWithVertical:NSLayoutAttributeTop referedVertical:NSLayoutAttributeTop];
            break;
        case LXLayoutOuterTypeLeftCenter:
            attribute = [[LX_layoutAttributes alloc] initWithHorizontal:NSLayoutAttributeRight referedHorizontal:NSLayoutAttributeLeft AndWithVertical:NSLayoutAttributeCenterY referedVertical:NSLayoutAttributeCenterY];
            break;
        case LXLayoutOuterTypeLeftBottom:
            attribute = [[LX_layoutAttributes alloc] initWithHorizontal:NSLayoutAttributeRight referedHorizontal:NSLayoutAttributeLeft AndWithVertical:NSLayoutAttributeBottom referedVertical:NSLayoutAttributeBottom];
            break;
        case LXLayoutOuterTypeRightTop:
            attribute = [[LX_layoutAttributes alloc] initWithHorizontal:NSLayoutAttributeLeft referedHorizontal:NSLayoutAttributeRight AndWithVertical:NSLayoutAttributeTop referedVertical:NSLayoutAttributeTop];
            break;
        case LXLayoutOuterTypeRightCenter:
            attribute = [[LX_layoutAttributes alloc] initWithHorizontal:NSLayoutAttributeLeft referedHorizontal:NSLayoutAttributeRight AndWithVertical:NSLayoutAttributeCenterY referedVertical:NSLayoutAttributeCenterY];
            break;
        case LXLayoutOuterTypeRightBottom:
            attribute = [[LX_layoutAttributes alloc] initWithHorizontal:NSLayoutAttributeLeft referedHorizontal:NSLayoutAttributeRight AndWithVertical:NSLayoutAttributeBottom referedVertical:NSLayoutAttributeBottom];
            break;
        default:
            break;
    }
    
    
    
    return attribute;
}
- (LX_layoutAttributes *)innerLayoutAttributesForType:(LXLayoutInnerType)type {
    
    LX_layoutAttributes *attribute = [[LX_layoutAttributes alloc]init];
    
    switch (type) {
        //左边
        case LXLayoutInnerTypeLeftTop:
            break;
        case LXLayoutInnerTypeLeftCenter:
            [attribute verticalAlignmentFrom:NSLayoutAttributeCenterY To:NSLayoutAttributeCenterY];
            break;
        case LXLayoutInnerTypeLeftBottom:
            [attribute verticalAlignmentFrom:NSLayoutAttributeBottom To:NSLayoutAttributeBottom];
            break;
          
        //中间
        case LXLayoutInnerTypeCenterTop:
            [attribute horizontalAlignmentFrom:NSLayoutAttributeCenterX To:NSLayoutAttributeCenterX];
            break;
        case LXLayoutInnerTypeCenter:
            attribute = [[LX_layoutAttributes alloc]initWithHorizontal:NSLayoutAttributeCenterX referedHorizontal:NSLayoutAttributeCenterX AndWithVertical:NSLayoutAttributeCenterY referedVertical:NSLayoutAttributeCenterY];
            break;
        case LXLayoutInnerTypeCenterBottom:
            [attribute horizontalAlignmentFrom:NSLayoutAttributeCenterX To:NSLayoutAttributeCenterX];
            [attribute verticalAlignmentFrom:NSLayoutAttributeBottom To:NSLayoutAttributeBottom];
            break;
            
        //右边
        case LXLayoutInnerTypeRightTop:
            [attribute horizontalAlignmentFrom:NSLayoutAttributeRight   To:NSLayoutAttributeRight];
            break;
        case LXLayoutInnerTypeRightCenter:
            [attribute horizontalAlignmentFrom:NSLayoutAttributeRight   To:NSLayoutAttributeRight];
            [attribute verticalAlignmentFrom:NSLayoutAttributeCenterY To:NSLayoutAttributeCenterY];
            break;
        case LXLayoutInnerTypeRightBottom:
            attribute = [[LX_layoutAttributes alloc] initWithHorizontal:NSLayoutAttributeRight referedHorizontal:NSLayoutAttributeRight AndWithVertical:NSLayoutAttributeBottom referedVertical:NSLayoutAttributeBottom];
            break;
            
        default:
            break;
    }
    
    return attribute;
}
- (NSArray *)lx_layoutWithAttributes:(LX_layoutAttributes *)attributes referedView:(UIView *)refView size:(CGSize)size offset:(CGPoint) offset {
    self.translatesAutoresizingMaskIntoConstraints = NO;

    
    NSMutableArray *cons = [NSMutableArray arrayWithArray:[self lx_positionConstrainsWithAttributes:attributes referedView:refView offset:offset]];

    if (size.height > 0 || size.width > 0) {
        [cons addObjectsFromArray:[self lx_sizeConstraints:size]];
    }

    [self.superview addConstraints:cons.copy];
    return cons.copy;
    

}
- (NSArray *)lx_positionConstrainsWithAttributes:(LX_layoutAttributes *)attributes referedView:(UIView *)refView offset:(CGPoint)offset {
    NSMutableArray *cons = [NSMutableArray array];
    [cons addObject:[NSLayoutConstraint constraintWithItem:self attribute:attributes.horizontal relatedBy:NSLayoutRelationEqual toItem:refView attribute:attributes.referHorizontal multiplier:1.0 constant:offset.x]];
    
    [cons addObject:[NSLayoutConstraint constraintWithItem:self attribute:attributes.vertical relatedBy:NSLayoutRelationEqual toItem:refView attribute:attributes.referVertical multiplier:1.0 constant:offset.y]];
    return cons.copy;
}

- (NSArray *)lx_tileLayout:(NSArray *)views Direction:(LXLayoutTileDirection)direction Inset:(UIEdgeInsets)inset {
    NSMutableArray *cons = [NSMutableArray array];
    //设置首个子视图
    UIView *firstView = (UIView *)views.firstObject;
    [cons addObjectsFromArray:[firstView lx_InnerLayoutForType:LXLayoutInnerTypeLeftTop referedView:self offset:CGPointMake(inset.left, inset.top)]];
    
    if (direction == LXLayoutTileDirectionHorizontal) {
        [cons addObject:[NSLayoutConstraint constraintWithItem:firstView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-inset.bottom]];
    } else {
        [cons addObject:[NSLayoutConstraint constraintWithItem:firstView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-inset.right]];
    }
    
    
    
    UIView *preView = firstView;
    for (int i = 1; i < views.count; i++) {
        UIView *subview = (UIView *)views[i];
        subview.translatesAutoresizingMaskIntoConstraints = NO;
        [cons addObjectsFromArray:[subview lx_sizeConstraintsReferView:preView]];
        if (direction == LXLayoutTileDirectionHorizontal) {
            [cons addObjectsFromArray:[subview lx_OuterLayoutForType:LXLayoutOuterTypeRightTop referedView:preView offset:CGPointMake(inset.left, 0)]];
        } else {
            [cons addObjectsFromArray:[subview lx_OuterLayoutForType:LXLayoutOuterTypeBottomLeft referedView:preView offset:CGPointMake(0, inset.top)]];
        }
        preView = subview;
        
    }
    UIView *lastView = (UIView *)views.lastObject;
    if (direction == LXLayoutTileDirectionHorizontal) {
        [cons addObject:[NSLayoutConstraint constraintWithItem:lastView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-inset.right]];
    } else {
        [cons addObject:[NSLayoutConstraint constraintWithItem:lastView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-inset.bottom]];
    }
    
    
  
    [self addConstraints:cons.copy];
    return cons.copy;
    
}

- (NSArray *)lx_sizeConstraintsReferView:(UIView *)refView {
    NSMutableArray *cons = [NSMutableArray array];
    [cons addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:refView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    [cons addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:refView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    return cons.copy;
}
- (NSArray *)lx_sizeConstraints:(CGSize)size {
    NSMutableArray *cons = [NSMutableArray array];
    [cons addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:size.width]];
    [cons addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:size.height]];
    return cons.copy;
}



@end
