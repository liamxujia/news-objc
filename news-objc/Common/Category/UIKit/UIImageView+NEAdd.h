//
//  UIImageView+NEAdd.h
//  wiki
//
//  Created by stlndm on 2017/10/16.
//  Copyright © 2017年 stlndm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (NEAdd)
// 增加捏合手势
- (void)ne_addPanGesture;

// 封装SDWebImage的渐进式加载图片
- (void)ne_setImageWithURL:(NSString *)imageURL
               placeholderImage:(UIImage *)placeholder
                completion:(void (^)(UIImage *image))completion;

// 返回百分比的加载图片
- (void)ne_setImageWithURL:(NSString *)imageURL
          placeholderImage:(UIImage *)placeholder
                  progress:(void (^)(CGFloat progress))progress
                completion:(void (^)(UIImage *image))completion;

// 制作特殊形状图片
- (UIImageView *)ne_imageViewWithSpecialImage:(NSString *)imageStr;

@end
