//
//  NENewsModel.h
//  news-objc
//
//  Created by stlndm on 2018/10/11.
//  Copyright © 2018 stlndm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NENewsModel : NSObject
@property (nonatomic , copy) NSString *title;
@property (nonatomic , copy) NSString *content;
@property (nonatomic , copy) NSString *posterId;
@property (nonatomic , assign) NSInteger publishDate;
@property (nonatomic , copy) NSString *publishDateStr;
@property (nonatomic , copy) NSString *posterScreenName;
@property (nonatomic , copy) NSString *url;
@property (nonatomic, strong) NSArray *imageUrls;
@end

NS_ASSUME_NONNULL_END
