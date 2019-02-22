//
//  HTTPClient.m
//  Cyano
//
//  Created by Yuanhai on 30/12/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "HTTPClient.h"

@interface HTTPClient()

@property (strong, nonatomic) NSString *urlString;

@end

@implementation HTTPClient

+ (HTTPClient *)sharedClient
{
    static HTTPClient *instance;
    @synchronized(self)
    {
        if(!instance)
        {
            instance = [[HTTPClient alloc] init];
        }
    }
    return instance;
}

- (AFHTTPSessionManager *)operationManager
{
    if (!_operationManager) {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfig.timeoutIntervalForRequest = 15;
        _operationManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:sessionConfig];
        _operationManager.completionQueue = dispatch_queue_create("customrequest", DISPATCH_QUEUE_CONCURRENT);
        _operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _operationManager;
}

// Cancle All Request
- (void)cancleAllRequest
{
    [self.operationManager.operationQueue cancelAllOperations];
}

// Request
- (NSURLSessionDataTask *)sendAsynchronousURL:(NSString *)urlString
                                   httpMethod:(NSString *)httpMethod
                                   parameters:(NSDictionary *)parameters
                                    bodyBlock:(void (^)(id <AFMultipartFormData> formData))block
                            completionHandler:(completionHandler)handler
{
    // URL重组
    self.urlString = urlString;
    
    // 除去空内容
    NSMutableDictionary *sendParames = [NSMutableDictionary dictionary];
    for (NSString *key in parameters)
    {
        id value = parameters[key];
        if (projectIsNotNull(value)) [sendParames setObject:value forKey:key];
    }
    parameters = sendParames;
    
    NSLog(@"完整请求地址:%@", urlString);
    NSLog(@"请求parameters:%@", [parameters JSONString]);
    
    NSString *path = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLSessionDataTask *operation = nil;
    
    if ([httpMethod isEqualToString:REQUEST_GET])
    {
        operation = [self.operationManager GET:path parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            [self requestSuccess:operation responseObject:responseObject handler:handler];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self requestFailure:operation error:error handler:handler];
        }];
    }
    else if ([httpMethod isEqualToString:REQUEST_POST])
    {
        if (block)
        {
            operation = [self.operationManager POST:path parameters:parameters constructingBodyWithBlock:block success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self requestSuccess:operation responseObject:responseObject handler:handler];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self requestFailure:operation error:error handler:handler];
            }];
        }
        else
        {
            operation = [self.operationManager POST:path parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self requestSuccess:operation responseObject:responseObject handler:handler];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self requestFailure:operation error:error handler:handler];
            }];
        }
    }
    else if ([httpMethod isEqualToString:REQUEST_PATCH])
    {
        operation = [self.operationManager PATCH:path parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self requestSuccess:operation responseObject:responseObject handler:handler];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self requestFailure:operation error:error handler:handler];
        }];
    }
    else if ([httpMethod isEqualToString:REQUEST_DELETE])
    {
        operation = [self.operationManager DELETE:path parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self requestSuccess:operation responseObject:responseObject handler:handler];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self requestFailure:operation error:error handler:handler];
        }];
    }
    
    return operation;
}

- (void)requestSuccess:(NSURLSessionDataTask *)operation responseObject:(id)responseObject handler:(completionHandler)handler
{
    NSLog(@"http operation:%@", [responseObject JSONString]);
    
    dispatch_async(dispatch_get_main_queue(), ^ {
        id response = responseObject;
        if (![response isKindOfClass:[NSDictionary class]] && ![response isKindOfClass:[NSArray class]]) response = nil;
        handler(response, YES);
    });
}

- (void)requestFailure:(NSURLSessionDataTask *)operation error:(NSError *)error handler:(completionHandler)handler
{
    dispatch_async(dispatch_get_main_queue(), ^ {
        handler(error, NO);
        [CVShowLabelView showTitle:@"网络不给力，请重试" detail:nil];
    });
}

@end
