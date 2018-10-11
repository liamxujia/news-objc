//
//  NEHTTPManager.m
//  CatHub
//
//  Created by stlndm on 2018/9/30.
//  Copyright © 2018 stlndm. All rights reserved.
//

#import "NEHTTPManager.h"
#import <AFNetworking/AFNetworking.h>

#ifdef DEBUG
static NSString *const kHTTPBaseURL = @"http://api.github.com";
#else
static NSString *const kHTTPBaseURL = @"http://api.github.com";
#endif

@interface NEHTTPManager ()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation NEHTTPManager
+ (instancetype)sharedManager {
    static NEHTTPManager *mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[NEHTTPManager alloc] init];
    });
    return mgr;
}

- (void)reachability {
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: {
                
                break;
            } case AFNetworkReachabilityStatusNotReachable: {
                
                break;
            } case AFNetworkReachabilityStatusReachableViaWWAN: {
                
                break;
            } case AFNetworkReachabilityStatusReachableViaWiFi: {
                
                break;
            }
        }
    }];
    [reachabilityManager startMonitoring];
}

- (BOOL)requestReachability {
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    return reachabilityManager.isReachable;
    
}

- (NSURLSessionDataTask *)GET:(NSString *)url params:(NSDictionary *)params success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    NSURLSessionDataTask *dataTask = [self.sessionManager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !success ?: success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ?: failure(error);
    }];
    return dataTask;
}

- (NSURLSessionDataTask *)POST:(NSString *)url params:(NSDictionary *)params success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    NSURLSessionDataTask *dataTask = [self.sessionManager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !success ?: success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure ?: failure(error);
    }];
    return dataTask;
}

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = 10.f;
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kHTTPBaseURL] sessionConfiguration:configuration];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    }
    return _sessionManager;
}
@end
