//
//  UIView+NEAdd.h
//  wiki
//
//  Created by stlndm on 2017/9/21.
//  Copyright © 2017年 stlndm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+NEAdd.h"

@interface UIView (CAAdd)
@property (nonatomic, assign) CGFloat   x;
@property (nonatomic, assign) CGFloat   y;
@property (nonatomic, assign) CGFloat   width;
@property (nonatomic, assign) CGFloat   height;
@property (nonatomic, assign) CGPoint   origin;
@property (nonatomic, assign) CGSize    size;
@property (nonatomic, assign) CGFloat   bottom;
@property (nonatomic, assign) CGFloat   right;
@property (nonatomic, assign) CGFloat   centerX;
@property (nonatomic, assign) CGFloat   centerY;

// 设置阴影
- (void)ne_setShadowColor:(UIColor *)color
                   radius:(CGFloat)radius;
- (void)ne_setShadowWithShadowColor:(UIColor *)shadowColor
                             radius:(CGFloat)radius
                        borderWidth:(CGFloat)borderWidth
                        borderColor:(UIColor *)borderColor;



- (void)ne_setLayerCornerRadius:(CGFloat)cornerRadius;
/**
 Will be cut into the rounded UIView and its subclasses.
 
 @param cornerRadius CGFloat cornerRadius
 @param borderWidth CGFloat borderWidth
 @param borderColor UIColor borderColor
 */
- (void)ne_setLayerCornerRadius:(CGFloat)cornerRadius
                 borderWidth:(CGFloat)borderWidth
                 borderColor:(UIColor *)borderColor;

@end

@interface CALayer (CAAdd)
@property (nonatomic, assign) CGFloat   x;
@property (nonatomic, assign) CGFloat   y;
@property (nonatomic, assign) CGFloat   width;
@property (nonatomic, assign) CGFloat   height;
@property (nonatomic, assign) CGPoint   origin;
@property (nonatomic, assign) CGSize    size;
@property (nonatomic, assign) CGFloat   bottom;
@property (nonatomic, assign) CGFloat   right;
@property (nonatomic, assign) CGFloat   centerX;
@property (nonatomic, assign) CGFloat   centerY;

@end
