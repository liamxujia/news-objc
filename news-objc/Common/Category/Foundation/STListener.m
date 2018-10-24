//
//  STListener.m
//  news-objc
//
//  Created by stlndm on 2018/10/19.
//  Copyright © 2018 stlndm. All rights reserved.
//

#import "STListener.h"
#import "NSObject+STListener.h"
#import "Aspects.h"

@interface STListener ()
@property (nonatomic, strong) UIView *maskView;
@end

@implementation STListener
+ (instancetype)sharedInstance {
    static STListener *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[STListener alloc] init];
    });
    return instance;
}

- (void)listen {
    NSDictionary *targets = @{@"NENewsPlainTextCell":@[@"contentLabel"]};
}


@end
