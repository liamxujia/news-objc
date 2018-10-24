//
//  STWitness.m
//  news-objc
//
//  Created by stlndm on 2018/10/23.
//  Copyright © 2018 stlndm. All rights reserved.
//

#import "STWitness.h"
@interface STWitness ()
@property (nonatomic, strong) UIView *maskView;
@end

@implementation STWitness
- (void)visible {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.maskView.alpha = 0;
//    [self showSubviewsLayout];
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:.8f initialSpringVelocity:25.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.maskView.alpha = 1;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss {
    self.maskView.alpha = 1;
//    [self dismissSubviewsLayout];
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:.8f initialSpringVelocity:25.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.maskView.alpha = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
