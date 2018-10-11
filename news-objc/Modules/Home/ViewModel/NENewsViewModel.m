//
//  NENewsViewModel.m
//  news-objc
//
//  Created by stlndm on 2018/10/11.
//  Copyright © 2018 stlndm. All rights reserved.
//

#import "NENewsViewModel.h"

@implementation NENewsViewModel
- (void)bindIndexPath:(NSIndexPath *)indexPath {
    self.title = @"标题";
    self.content = @"内容";
    self.timeline = @"时间";
    self.posterName = @"来自";
}
@end
