//
//  NEProgressHUD.m
//  Camera
//
//  Created by stlndm on 2017/2/6.
//  Copyright © 2017年 stlndm. All rights reserved.
//

#import "NEProgressHUD.h"
#import <Masonry/Masonry.h>
#import <SVProgressHUD/SVProgressHUD.h>

#define KeyWindow [UIApplication sharedApplication].keyWindow

#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

static NSInteger Showtime = 1;
static NSInteger SystemAnimationDuration = 0.25;

@interface NEProgressHUD ()

// Animation shadow
@property (nonatomic, strong) UIView *indicatorView;
// ToastView
@property (nonatomic, strong) UIView *toastView;
// Spin animation
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
// ToastShowMessage
@property (nonatomic, strong) UILabel *toastLabel;
@property (nonatomic, strong) SVProgressHUD *svProgress;

@end
@implementation NEProgressHUD

+ (instancetype)sharedInstance {
    static NEProgressHUD *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NEProgressHUD alloc] init];
    });
    
    return instance;
}

#pragma mark 《$ ---------------- LoadingAction ---------------- $》
+ (void)showWithView:(UIView *)view {
    [self configureProgressHUD];
    [SVProgressHUD setContainerView:view];
    [SVProgressHUD show];
}

+ (void)showWithStatus:(NSString *)status view:(UIView *)view {
    [self configureProgressHUD];
    [SVProgressHUD setContainerView:view];
    [SVProgressHUD showWithStatus:status];
}

+ (void)showInfoWithStatus:(NSString *)status view:(UIView *)view {
    [self showInfoWithStatus:status duration:Showtime view:view];
}

+ (void)showInfoWithStatus:(NSString *)status duration:(NSInteger)duration view:(UIView *)view {
    [self configureProgressHUD];
    [self dissmissAfterDelay:duration completion:nil];
    [SVProgressHUD setContainerView:view];
    [SVProgressHUD showInfoWithStatus:status];
}

+ (void)showSuccessWithStatus:(NSString *)status view:(UIView *)view {
    [self showSuccessWithStatus:status view:view duration:Showtime];
}

+ (void)showSuccessWithStatus:(NSString *)status view:(UIView *)view completion:(void (^)(void))completion {
    [self showSuccessWithStatus:status view:view duration:Showtime completion:completion];
}

+ (void)showSuccessWithStatus:(NSString *)status view:(UIView *)view duration:(NSInteger)duration  {
    [self showSuccessWithStatus:status view:view duration:duration completion:nil];
}

+ (void)showSuccessWithStatus:(NSString *)status view:(UIView *)view duration:(NSInteger)duration completion:(void (^)(void))completion {
    [self configureProgressHUD];
    [self dissmissAfterDelay:duration completion:completion];
    [SVProgressHUD setContainerView:view];
    [SVProgressHUD showSuccessWithStatus:status];
}

+ (void)showFailureWithStatus:(NSString *)status view:(UIView *)view {
    [self showFailureWithStatus:status view:view duration:Showtime];
}

+ (void)showFailureWithStatus:(NSString *)status view:(UIView *)view completion:(void (^)(void))completion {
    [self showFailureWithStatus:status view:view duration:Showtime completion:completion];
}

+ (void)showFailureWithStatus:(NSString *)status view:(UIView *)view duration:(NSInteger)duration {
    [self showFailureWithStatus:status view:view duration:duration completion:nil];
}

+ (void)showFailureWithStatus:(NSString *)status view:(UIView *)view duration:(NSInteger)duration completion:(void (^)(void))completion {
    [self configureProgressHUD];
    [self dissmissAfterDelay:duration completion:completion];
    [SVProgressHUD setContainerView:view];
    [SVProgressHUD showErrorWithStatus:status];
}

+ (void)dissmissAfterDelay:(NSInteger)duration completion:(void (^)(void))completion {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dissmiss];
        !completion ?: completion();
    });
}

+ (void)configureProgressHUD {
    CGFloat size = 80;
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setFadeInAnimationDuration:SystemAnimationDuration];
    [SVProgressHUD setFadeOutAnimationDuration:SystemAnimationDuration];
    [SVProgressHUD setMinimumSize:CGSizeMake(size, size)];
    [SVProgressHUD setFont:kBoldFont(14.f)];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

+ (void)showProgress:(CGFloat)progress view:(UIView *)view {
    [self configureProgressHUD];
    [self showProgress:progress view:view state:nil];
    if (progress == 1) {
        [self dissmiss];
    }
}

+ (void)showProgress:(CGFloat)progress view:(UIView *)view  state:(NSString *)state {
    [self configureProgressHUD];
    [SVProgressHUD setContainerView:view];
    [SVProgressHUD showProgress:progress status:state];
    if (progress == 1) {
        [self dissmiss];
    }
}

// Hide loading animation
+ (void)dissmiss {
    [SVProgressHUD dismiss];
}
@end
