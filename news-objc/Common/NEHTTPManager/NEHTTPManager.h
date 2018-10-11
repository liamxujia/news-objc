//
//  NEHTTPManager.h
//  CatHub
//
//  Created by stlndm on 2018/9/30.
//  Copyright © 2018 stlndm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NEHTTPManager : NSObject
+ (instancetype)sharedManager;
- (void)reachability;
- (BOOL)requestReachability;
- (NSURLSessionDataTask *)GET:(NSString *)url
                       params:(NSDictionary *)params
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure;
- (NSURLSessionDataTask *)POST:(NSString *)url
                        params:(NSDictionary *)params
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
