//
//  NESearchView.h
//  LaniOSApp
//
//  Created by stlndm on 2018/6/22.
//  Copyright © 2018年 stlndm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NESearchViewHandler)(NSString *keyword);

@interface NESearchView : UIView
@property (nonatomic, copy) NESearchViewHandler searchViewBlock;
@property (nonatomic, strong) RACSignal<NSString *> *searchSignal;
- (void)setPlaceHolder:(NSString *)placeHolder;
@end
