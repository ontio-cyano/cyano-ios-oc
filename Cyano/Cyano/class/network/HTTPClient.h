//
//  HTTPClient.h
//  Cyano
//
//  Created by Yuanhai on 30/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^completionHandler)(id data, BOOL success);

@interface HTTPClient : NSObject

@property (strong, nonatomic) AFHTTPSessionManager *operationManager;

+ (HTTPClient *)sharedClient;

- (void)cancleAllRequest;

// Request
- (NSURLSessionDataTask *)sendAsynchronousURL:(NSString *)urlString
                                   httpMethod:(NSString *)httpMethod
                                   parameters:(NSDictionary *)parameters
                                    bodyBlock:(void (^)(id <AFMultipartFormData> formData))block
                            completionHandler:(completionHandler)handler;

@end
