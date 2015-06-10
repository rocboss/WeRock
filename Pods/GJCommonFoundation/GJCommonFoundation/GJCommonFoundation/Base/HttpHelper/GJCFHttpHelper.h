//
//  GJCFHttpHelper.h
//  GJCommonFoundation
//  请求帮助类（封装了AFNetwork）
//  Created by liyi on 14-9-10.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorking.h"
typedef void(^GJCFHttpSuccessBlock)(id responseObj);
typedef void(^GJCFHttpFailBlock)(NSError *error);
typedef void(^GJCFHttpPrograssBlock)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);


/**
 *  结果格式枚举
 */
typedef enum _GJCFHttpResponseType {
    /**
     *  JSON
     */
    GJCFHttpTypeJson = 0,
    /**
     *  XML
     */
    GJCFHttpTypeXML = 1,
    /**
     *  PList
     */
    GJCFHttpTypePlist = 2
} GJCFHttpResponseType;

@interface GJCFHttpHelper : NSObject

/**
 *  单例
 *
 *  @return return value description
 */
+ (instancetype)share;


/**
 *  Post请求
 *
 *  @param urlString    url
 *  @param header       请求头字典
 *  @param body         body字符串
 *  @param responseType 结果类型
 *  @param sBlock       成功block
 *  @param fBlock       失败block
 *
 *  @return 请求id requestId
 */
- (NSUInteger)requestPostUrl:(NSString *)urlString  header:(NSMutableDictionary *)header body:(NSString *)body responseType:(GJCFHttpResponseType)responseType sBlock:(GJCFHttpSuccessBlock)sBlock fBlock:(GJCFHttpFailBlock)fBlock;

/**
 *  Post请求
 *
 *  @param urlString    url
 *  @param header       请求头字典
 *  @param bodyData         body数据
 *  @param responseType 结果类型
 *  @param sBlock       成功block
 *  @param fBlock       失败block
 *
 *  @return 请求id requestId
 */
- (NSUInteger)requestPostUrl:(NSString *)urlString  header:(NSMutableDictionary *)header bodyData:(NSData *)bodyData responseType:(GJCFHttpResponseType)responseType sBlock:(GJCFHttpSuccessBlock)sBlock fBlock:(GJCFHttpFailBlock)fBlock;

/**
 *  Get请求
 *
 *  @param urlString    url
 *  @param header       请求头字典
 *  @param body         body字典
 *  @param responseType 结果类型
 *  @param sBlock       成功的block
 *  @param fBlock       失败的block
 *
 *  @return 请求id requestId
 */
- (NSUInteger)requestGetUrl:(NSString *)urlString header:(NSMutableDictionary *)header body:(NSString *)body responseType:(GJCFHttpResponseType)responseType sBlock:(GJCFHttpSuccessBlock)sBlock fBlock:(GJCFHttpFailBlock)fBlock;

/**
 *  Get图片
 *
 *  @param urlString url
 *  @param header    请求头字典
 *  @param sBlock    成功block
 *  @param fBlock    失败block
 *  @param pBlock    进度block
 *
 *  @return 请求id requestId
 */
- (NSUInteger)requestGetImageUrl:(NSString *)urlString header:(NSMutableDictionary *)header sBlock:(GJCFHttpSuccessBlock)sBlock fBlock:(GJCFHttpFailBlock)fBlock pBlock:(GJCFHttpPrograssBlock)pBlock;





/**
 *  取消所有的请求
 */
- (void)cancelAllRequest;

/**
 *  根据requestId取消请求
 *
 *  @param requestId 请求id
 */
- (void)cancelRequestByRequestId:(NSUInteger)requestId;



/**
 *  根据请求id获取operation
 *
 *  @param requestId 请求id
 *
 *  @return operation
 */
- (AFHTTPRequestOperation *)operationByRequestId:(NSUInteger)requestId;
@end
