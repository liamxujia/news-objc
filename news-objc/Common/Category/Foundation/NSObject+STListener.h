//
//  NSObject+STListener.h
//  news-objc
//
//  Created by stlndm on 2018/10/18.
//  Copyright © 2018 stlndm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Listener)
- (NSArray *)st_allPropertyKey;
- (NSArray *)st_allPropertValue;
- (NSDictionary *)st_allPropertys;
@end

NS_ASSUME_NONNULL_END
