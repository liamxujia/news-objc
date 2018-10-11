//
//  NESuperViewModel.m
//  MeiyeCommon
//
//  Created by stlndm on 2018/8/8.
//  Copyright © 2018年 stlndm. All rights reserved.
//

#import "NESuperViewModel.h"

@implementation NESuperViewModel
- (instancetype)init {
    if (self = [super init]) {
        _feedEntities = [NSMutableArray array];
        _titles = [NSMutableArray array];
        _results = [NSMutableArray array];
        _numberOfSections = 2;
        _numberOfRows = 10;
        _rowHeight = 50;
        _section = 0;
        _page = 1;
        _count = 20;
        _refresh = true;
        _lastIndex = true;
    }
    return self;
}

#pragma mark - Public
- (void)bindSection:(NSUInteger)section {
    self.section = section;
}

- (void)feedEntitiesWithResults:(NSArray *)results completedHandler:(CompletedHandler)completedHandler {
    if (self.isRefresh) {
        [self.feedEntities removeAllObjects];
        [self.feedEntities addObjectsFromArray:results];
    } else {
        [self.feedEntities addObjectsFromArray:results];
    }
    !completedHandler ?: completedHandler();
}

- (void)feedEntities:(NSMutableArray *)feedEntities results:(NSArray *)results completedHandler:(CompletedHandler)completedHandler {
    if (self.isRefresh) {
        [feedEntities removeAllObjects];
        [feedEntities addObjectsFromArray:results];
    } else {
        [feedEntities addObjectsFromArray:results];
    }
    !completedHandler ?: completedHandler();
}
@end
