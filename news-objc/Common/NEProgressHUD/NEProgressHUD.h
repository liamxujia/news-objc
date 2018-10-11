//
//  NEProgressHUD.h
//  Camera
//
//  Created by stlndm on 2017/2/6.
//  Copyright © 2017年 stlndm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NEProgressHUD : NSObject

+ (instancetype)sharedInstance;

/**
 Show loading animation
 */
+ (void)showWithView:(UIView *)view;

/**
 Show loading animation with status 

 @param status Status like title
 */
+ (void)showWithStatus:(NSString *)status
                  view:(UIView *)view;

/**
 ShowInfoWithStatus

 @param status Status like title
 */
+ (void)showInfoWithStatus:(NSString *)status
                      view:(UIView *)view;

+ (void)showInfoWithStatus:(NSString *)status
                  duration:(NSInteger)duration
                      view:(UIView *)view;

/**
 ShowInfoWithStatus

 @param status Status like title
 */
+ (void)showSuccessWithStatus:(NSString *)status
                         view:(UIView *)view;
+ (void)showSuccessWithStatus:(NSString *)status
                         view:(UIView *)view
                   completion:(void(^)(void))completion;
+ (void)showSuccessWithStatus:(NSString *)status
                         view:(UIView *)view
                     duration:(NSInteger)duration;
+ (void)showSuccessWithStatus:(NSString *)status
                         view:(UIView *)view
                     duration:(NSInteger)duration
                   completion:(void (^)(void))completion;

/**
 ShowInfoWithStatus

 @param status Status like title
 */
+ (void)showFailureWithStatus:(NSString *)status
                         view:(UIView *)view;
+ (void)showFailureWithStatus:(NSString *)status
                         view:(UIView *)view
                   completion:(void (^)(void))completion;
+ (void)showFailureWithStatus:(NSString *)status
                         view:(UIView *)view
                     duration:(NSInteger)duration;
+ (void)showFailureWithStatus:(NSString *)status
                         view:(UIView *)view
                     duration:(NSInteger)duration
                   completion:(void (^)(void))completion;

/**
 Hide loading animation
 */


/**
 ShowProgress

 @param progress progres
 */
+ (void)showProgress:(CGFloat)progress
                view:(UIView *)view;
+ (void)showProgress:(CGFloat)progress
                view:(UIView *)view
               state:(NSString *)state;

/**
 ProgressHUD dissmiss from current view.
 */
+ (void)dissmiss;
@end
