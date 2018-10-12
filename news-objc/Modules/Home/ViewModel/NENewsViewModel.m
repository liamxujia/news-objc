//
//  NENewsViewModel.m
//  news-objc
//
//  Created by stlndm on 2018/10/11.
//  Copyright © 2018 stlndm. All rights reserved.
//

#import "NENewsViewModel.h"
#import "NENewsModel.h"
#import "NEHTTPManager.h"
#import <YYModel/YYModel.h>

@implementation NENewsViewModel
- (NSUInteger)numberOfRows {
    return self.feedEntities.count;
}

- (RACSignal *)newsSignal {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@"Pe2bj27PF0F5JfUvOKHd07zbx6BTRowGSJ7d1bcefzai1ed6OCsQrU02JF86vAFZ" forKey:@"apikey"];
        [params setObject:self.keyword forKey:@"kw"];
        NSURLSessionTask *task = [[NEHTTPManager sharedManager] GET:@"http://api01.idataapi.cn:8000/news/qihoo" params:params success:^(id responseObject) {
            NSArray *news = [NSArray yy_modelArrayWithClass:[NENewsModel class] json:responseObject[@"data"]];
            [self feedEntitiesWithResults:news completedHandler:^{
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }];
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

- (void)bindIndexPath:(NSIndexPath *)indexPath {
    NENewsModel *model = self.feedEntities[indexPath.row];
    self.title = model.title;
    self.content = model.content;
    self.timeline = model.publishDateStr;
    self.posterName = model.posterScreenName;
    self.pictureUrls = model.imageUrls;
    self.newsUrl = model.url;
    self.cellIdentifier = NENewsPlainTextCellIdentifer;
    self.cellIdentifier = self.pictureUrls.count >= 3 ? NENewsTreblePictureCellIdentifer : NENewsPlainTextCellIdentifer;
    self.deleteCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [self.feedEntities removeObject:model];
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}

- (RACCommand *)searchCommand {
    /*
    RACSignal *accountSignal = [RACObserve(self, account) map:^id(NSString *value) {
        return value.length >= 6 ? @(true) : @(false);
    }];
    RACSignal *passwordSignal = [RACObserve(self, password) map:^id(NSString *value) {
        return value.length >= 6 ? @(true) : @(false);
    }];
    RACSignal *inviteCodeSignal = [RACObserve(self, inviteCode) map:^id(NSString *value) {
        return value.length == 6 ? @(true) : @(false);
    }];
    RACSignal *IDCodeSignal = [RACObserve(self, IDCode) map:^id(NSString *value) {
        return value.length == 18 ? @(true) : @(false);
    }];
    RACSignal *userNameSignal = [RACObserve(self, userName) map:^id(NSString *value) {
        return value.length > 0 ? @(true) : @(false);
    }];
    RACSignal *enableSignal = [RACSignal combineLatest:@[accountSignal, passwordSignal, inviteCodeSignal, userNameSignal, IDCodeSignal] reduce:^id(NSNumber *account, NSNumber *password, NSNumber *inviteCode, NSNumber *userName, NSNumber *IDCode){
        return @([account boolValue] && [password boolValue] && [inviteCode boolValue] && [userName boolValue] && [IDCode boolValue]);
    }];
     */
    RACSignal *enableSignal = [RACObserve(self, keyword) map:^id(NSString *value) {
        return value.length >= 2  ? @(true) : @(false);
    }];
    return [[RACCommand alloc] initWithEnabled:enableSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}
@end
