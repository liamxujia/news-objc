//
//  NENewsViewModel.h
//  news-objc
//
//  Created by stlndm on 2018/10/11.
//  Copyright © 2018 stlndm. All rights reserved.
//

#import "NESuperViewModel.h"

static NSString *const NENewsPlainTextCellIdentifer = @"NENewsPlainTextCell";
static NSString *const NENewsFirstPictureCellIdentifer = @"NENewsFirstPictureCell";
static NSString *const NENewsTreblePictureCellIdentifer = @"NENewsTreblePictureCell";

@interface NENewsViewModel : NESuperViewModel
@property(nonatomic, copy) NSString *keyword;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *content;
@property(nonatomic, copy) NSString *timeline;
@property(nonatomic, copy) NSString *posterName;
- (RACSignal *)newsSignal;
- (RACCommand *)searchCommand;
@end

