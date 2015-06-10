//
//  AFHTTPClient+GJCFHttpHelper.h
//  GJCommonFoundation
//
//  Created by liyi on 14-9-10.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import "AFHTTPClient.h"
@interface AFHTTPClient (GJCFHttpHelper)
/**
 *  AFHTTPClient的baseURL
 */
@property (readwrite, nonatomic) NSURL *baseURL;
/**
 *  注册OperationClass的数组
 */
@property (readwrite, nonatomic) NSMutableArray *registeredHTTPOperationClassNames;
/**
 *  默认头字典
 */
@property (readwrite, nonatomic) NSMutableDictionary *defaultHeaders;
/**
 *  当前Client的operation队列
 */
@property (readwrite, nonatomic) NSOperationQueue *operationQueue;


/**
 *  清楚默认头数据
 */
- (void)gjcf_clearDefaultHeaders;

/**
 *  get方法
 *
 *  @param url      url
 *  @param userInfo 临时传递数据
 *  @param success  成功block
 *  @param failure  失败block
 */
- (AFHTTPRequestOperation *)gjcf_getWithUrl:(NSURL *)url
          userInfo:(NSDictionary *)userInfo
           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;




/**
 *  post请求
 *
 *  @param url      url
 *  @param body     body字符串
 *  @param userInfo 临时传递数据
 *  @param success  成功block
 *  @param failure  失败block
 */
- (AFHTTPRequestOperation *)gjcf_postWithUrl:(NSURL *)url
               body:(NSString *)body
           userInfo:(NSDictionary *)userInfo
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  post请求
 *
 *  @param url     url
 *  @param body    body二进制
 *  @param dict    临时传递数据
 *  @param success 成功block
 *  @param failure 失败block
 */
- (AFHTTPRequestOperation *)gjcf_postWithUrl:(NSURL *)url
           databody:(NSData *)body
           userInfo:(NSDictionary *)dict
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  post请求（带进度）
 *
 *  @param url      url
 *  @param body     body上传进度
 *  @param dict     字典
 *  @param progress 进度
 *  @param success  成功
 *  @param failure  失败
 */
- (AFHTTPRequestOperation *)gjcf_postWithUrl:(NSURL *)url
           databody:(NSData *)body
           userInfo:(NSDictionary *)dict
uploadProgressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite))progress
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end



