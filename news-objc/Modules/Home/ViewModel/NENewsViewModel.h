//
//  NENewsViewModel.h
//  news-objc
//
//  Created by stlndm on 2018/10/11.
//  Copyright © 2018 stlndm. All rights reserved.
//

#import "NESuperViewModel.h"

static NSString *const NENewsPlainTextCell = @"NENewsPlainTextCell";
static NSString *const NENewsFirstPictureCell = @"NENewsFirstPictureCell";
static NSString *const NENewsTreblePictureCell = @"NENewsTreblePictureCell";

@interface NENewsViewModel : NESuperViewModel
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *content;
@property(nonatomic, copy) NSString *timeline;
@property(nonatomic, copy) NSString *posterName;
@end

