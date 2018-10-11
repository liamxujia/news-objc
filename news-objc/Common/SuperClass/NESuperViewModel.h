//
//  NESuperViewModel.h
//  MeiyeCommon
//
//  Created by stlndm on 2018/8/8.
//  Copyright © 2018年 stlndm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NEViewModelProtocol.h"

typedef void(^SuccessHandler)(id results);
typedef void(^FailureHandler)(NSError *error);
typedef void(^CompletedHandler)(void);

@interface NESuperViewModel : NSObject <NEViewModelProtocol>
@property(nonatomic, copy) NSString *titleForHeader;
@property(nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, strong) NSMutableArray *feedEntities;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *results;
@property (nonatomic, assign) NSUInteger numberOfRows;
@property (nonatomic, assign) NSUInteger numberOfSections;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) CGFloat rowWidth;
@property (nonatomic, assign) NSUInteger section;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign, getter=isRefresh) BOOL refresh;
@property (nonatomic, assign, getter=isLastIndex) BOOL lastIndex;

- (void)feedEntitiesWithResults:(NSArray *)results
               completedHandler:(CompletedHandler)completedHandler;
- (void)feedEntities:(NSMutableArray *)feedEntities
             results:(NSArray *)results
    completedHandler:(CompletedHandler)completedHandler;
@end
