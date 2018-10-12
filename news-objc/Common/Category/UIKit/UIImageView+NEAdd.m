//
//  UIImageView+NEAdd.m
//  wiki
//
//  Created by stlndm on 2017/10/16.
//  Copyright © 2017年 stlndm. All rights reserved.
//

#import "UIImageView+NEAdd.h"
#import "UIImageView+WebCache.h"

static CGFloat currentScale = 1;
@implementation UIImageView (NEAdd)

- (void)ne_addPanGesture {
    // 添加捏合手势
    UIPinchGestureRecognizer *pinGesture = [[UIPinchGestureRecognizer alloc] init];
    [[pinGesture rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        UIImageView *previewImage = (UIImageView *)pinGesture.view;
        if(pinGesture.state == UIGestureRecognizerStateBegan) {
            
        } else if (pinGesture.state == UIGestureRecognizerStateChanged) {
            previewImage.transform = CGAffineTransformMakeScale(pinGesture.scale * currentScale, pinGesture.scale * currentScale);
        } else if(pinGesture.state == UIGestureRecognizerStateEnded) {
            // 结束后调整(最小为1x大小，最大为2x大小)
            [UIView animateWithDuration:0.2 animations:^{
                if(pinGesture.scale < 1){
                    previewImage.transform = CGAffineTransformMakeScale(1, 1);
                    pinGesture.scale = 1;
                } else if(pinGesture.scale > 2){
                    previewImage.transform = CGAffineTransformMakeScale(2, 2);
                    pinGesture.scale = 2;
                }
                currentScale = pinGesture.scale;
                // 取消一切形变
//                  previewImage.transform = CGAffineTransformIdentity;
            }];
        }
    }];
    [self addGestureRecognizer:pinGesture];
    self.userInteractionEnabled = YES;
}

- (UIImageView *)ne_imageViewWithSpecialImage:(NSString *)imageStr {
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor lightGrayColor].CGColor;
    maskLayer.strokeColor = [UIColor clearColor].CGColor;
    maskLayer.frame = self.bounds;
    /*
     0.1, 0.1
     |-------------|
     |'-----------'|
     |'           '|
     |'           '|
     |'           '|
     |'-----------'|
     |-------------|
     0.5, 0.5
     */
    maskLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.1, 0.1);
    maskLayer.contentsScale = [UIScreen mainScreen].scale;
    maskLayer.contents = (id)[UIImage imageNamed:imageStr].CGImage;
    
    self.layer.mask = maskLayer;
    self.frame = self.bounds;
    
    return self;
}

- (void)ne_setImageWithURL:(NSString *)imageURL placeholderImage:(UIImage *)placeholder completion:(void (^)(UIImage *image))completion {
    __weak typeof(self) weakSelf = self;
    [self sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        __strong  typeof(self) strongSelf = weakSelf;
        if (image && cacheType == SDImageCacheTypeNone) {
            CATransition *transition = [CATransition animation];
            transition.type = kCATransitionFade;
            transition.duration = 0.6;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [strongSelf.layer addAnimation:transition forKey:nil];
        }
        !completion ?: completion(image);
    }];
}

- (void)ne_setImageWithURL:(NSString *)imageURL placeholderImage:(UIImage *)placeholder progress:(void (^)(CGFloat progress))progress completion:(void (^)(UIImage *image))completion {
    __weak typeof(self) weakSelf = self;
    [self sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:placeholder options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            !progress ?: progress((CGFloat)receivedSize / (CGFloat)expectedSize);
        }];
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        __strong  typeof(self) strongSelf = weakSelf;
        if (image && cacheType == SDImageCacheTypeNone) {
            CATransition *transition = [CATransition animation];
            transition.type = kCATransitionFade;
            transition.duration = 0.6;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [strongSelf.layer addAnimation:transition forKey:nil];
        }
        !completion ?: completion(image);
    }];
}

@end
