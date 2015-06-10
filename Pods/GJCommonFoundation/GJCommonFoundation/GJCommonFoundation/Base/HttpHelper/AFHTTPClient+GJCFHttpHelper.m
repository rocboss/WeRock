//
//  AFHTTPClient+GJCFHttpHelper.m
//  GJCommonFoundation
//
//  Created by liyi on 14-9-10.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import "AFHTTPClient+GJCFHttpHelper.h"
#import "AFHTTPRequestOperation.h"
#import "GJCFConstantManager.h"


@implementation AFHTTPClient (GJCFHttpHelper)

@dynamic baseURL;
@dynamic defaultHeaders;
@dynamic operationQueue;
@dynamic registeredHTTPOperationClassNames;


- (void)gjcf_clearDefaultHeaders
{
    
    for (id obj in [self.defaultHeaders allKeys]) {
        if ([obj isEqualToString:@"Accept-Encoding"]) {
            continue;
        }
        if ([obj isEqualToString:@"contentformat"]) {
            continue;
        }
        if ([obj isEqualToString:@"Accept-Language"]) {
            continue;
        }
        if ([obj isEqualToString:@"User-Agent"]) {
            continue;
        }
        
        [self.defaultHeaders removeObjectForKey:obj];
    }
    
    
    
    
}

- (AFHTTPRequestOperation *)gjcf_getWithUrl:(NSURL *)url
          userInfo:(NSDictionary *)userInfo
           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    self.baseURL = url;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setHTTPShouldUsePipelining:YES];
    [request setAllHTTPHeaderFields:self.defaultHeaders];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    operation.userInfo = userInfo;
    [self enqueueHTTPRequestOperation:operation];
    return operation;
}




- (AFHTTPRequestOperation *)gjcf_postWithUrl:(NSURL *)url
               body:(NSString *)body
           userInfo:(NSDictionary *)userInfo
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    self.baseURL = url;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:self.stringEncoding]];
    [request setAllHTTPHeaderFields:self.defaultHeaders];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    operation.userInfo = userInfo;
    [self enqueueHTTPRequestOperation:operation];
    return operation;
}

- (AFHTTPRequestOperation *)gjcf_postWithUrl:(NSURL *)url
           databody:(NSData *)body
           userInfo:(NSDictionary *)dict
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    return [self gjcf_postWithUrl:url databody:body userInfo:dict uploadProgressBlock:nil success:success failure:failure];
    
}

- (AFHTTPRequestOperation *)gjcf_postWithUrl:(NSURL *)url
           databody:(NSData *)body
           userInfo:(NSDictionary *)dict
uploadProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progress
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    self.baseURL = url;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:body];
    [request setAllHTTPHeaderFields:self.defaultHeaders];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.userInfo = dict;
    [operation setCompletionBlockWithSuccess:success failure:failure];
    if (progress) {
        [operation setUploadProgressBlock:progress];
    }
    [self enqueueHTTPRequestOperation:operation];
    
    return operation;
}
@end





