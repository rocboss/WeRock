//
//  GJCFHttpHelper.m
//  GJCommonFunction
//
//  Created by liyi on 14-9-10.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import "GJCFHttpHelper.h"
#import "AFHTTPClient+GJCFHttpHelper.h"
#import "GJCFHttpHelperBase.h"
@interface GJCFHttpHelper()

@property (nonatomic,strong) AFHTTPClient *httpClient;

/**
 *  请求字典，用于保存hashCode和operation
 */
@property (nonatomic,strong) NSMutableDictionary *requestDict;

@end

@implementation GJCFHttpHelper
@synthesize requestDict;
+ (instancetype)share
{
    static GJCFHttpHelper *helper = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[GJCFHttpHelper alloc] init];
        helper.httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.baidu.com"]];
        [helper.httpClient setDefaultHeader:@"Accept-Encoding" value:@"gzip"];
        [helper.httpClient setDefaultHeader:@"contentformat" value:@"json2"];
        
    });
    
    return helper;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        requestDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSUInteger)requestPostUrl:(NSString *)urlString  header:(NSMutableDictionary *)header body:(NSString *)body responseType:(GJCFHttpResponseType)responseType sBlock:(GJCFHttpSuccessBlock)sBlock fBlock:(GJCFHttpFailBlock)fBlock
{
    if(urlString == nil || urlString.length == 0)
    {
        if (fBlock) {
            
            NSError *error = [NSError errorWithDomain:@"传入错误的参数" code:GJCFHttpParamError userInfo:nil];
            fBlock(error);
        }
        return 0;
    }
    [self.httpClient gjcf_clearDefaultHeaders];
    
    
    
    
    NSArray *keys = [header allKeys];
    for (NSString *key in keys) {
        [self.httpClient setDefaultHeader:key value:[header objectForKey:key]];
    }
    
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperation *operation = [self.httpClient gjcf_postWithUrl:[NSURL URLWithString:urlString] body:body userInfo:nil  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (operation.response.statusCode != 200) {
            if (fBlock) {
                
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                [userInfo setObject:[NSNumber numberWithInt:operation.response.statusCode] forKey:@"statusCode"];
                
                NSError *error = [NSError errorWithDomain:@"http result error" code:GJCFHttpNo200Error userInfo:userInfo];
                fBlock(error);
            }
        }
        
        if (sBlock) {
            sBlock(responseObject);
        }
        
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.requestDict removeObjectForKey:[NSNumber numberWithUnsignedInteger:operation.hash]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fBlock) {
            fBlock(error);
        }
        
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.requestDict removeObjectForKey:[NSNumber numberWithUnsignedInteger:operation.hash]];
        }
    }];
    
    [requestDict setObject:operation forKey:[NSNumber numberWithUnsignedInteger:operation.hash]];
    return operation.hash;
}


- (NSUInteger)requestPostUrl:(NSString *)urlString  header:(NSMutableDictionary *)header bodyData:(NSData *)bodyData responseType:(GJCFHttpResponseType)responseType sBlock:(GJCFHttpSuccessBlock)sBlock fBlock:(GJCFHttpFailBlock)fBlock
{
    if(urlString == nil || urlString.length == 0)
    {
        if (fBlock) {
            
            NSError *error = [NSError errorWithDomain:@"传入错误的参数" code:GJCFHttpParamError userInfo:nil];
            fBlock(error);
        }
        return 0;
    }
    [self.httpClient gjcf_clearDefaultHeaders];
    
    
    
    
    NSArray *keys = [header allKeys];
    for (NSString *key in keys) {
        [self.httpClient setDefaultHeader:key value:[header objectForKey:key]];
    }
    
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperation *operation = [self.httpClient gjcf_postWithUrl:[NSURL URLWithString:urlString] databody:bodyData userInfo:nil  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (operation.response.statusCode != 200) {
            if (fBlock) {
                
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                [userInfo setObject:[NSNumber numberWithInt:operation.response.statusCode] forKey:@"statusCode"];
                
                NSError *error = [NSError errorWithDomain:@"http result error" code:GJCFHttpNo200Error userInfo:userInfo];
                fBlock(error);
            }
        }
        
        if (sBlock) {
            sBlock(responseObject);
        }
        
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.requestDict removeObjectForKey:[NSNumber numberWithUnsignedInteger:operation.hash]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fBlock) {
            fBlock(error);
        }
        
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.requestDict removeObjectForKey:[NSNumber numberWithUnsignedInteger:operation.hash]];
        }
    }];
    
    [requestDict setObject:operation forKey:[NSNumber numberWithUnsignedInteger:operation.hash]];
    return operation.hash;
}





- (NSUInteger)requestGetUrl:(NSString *)urlString header:(NSMutableDictionary *)header body:(NSString *)body responseType:(GJCFHttpResponseType)responseType sBlock:(GJCFHttpSuccessBlock)sBlock fBlock:(GJCFHttpFailBlock)fBlock
{
    if(urlString == nil || urlString.length == 0)
    {
        if (fBlock) {
            
            NSError *error = [NSError errorWithDomain:@"传入错误的参数" code:GJCFHttpParamError userInfo:nil];
            fBlock(error);
        }
        return 0;
    }
    
    [self.httpClient gjcf_clearDefaultHeaders];
    
    NSArray *keys = [header allKeys];
    for (NSString *key in keys) {
        [self.httpClient setDefaultHeader:key value:[header objectForKey:key]];
    }
    
    
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperation *operation = [self.httpClient gjcf_getWithUrl:[NSURL URLWithString:urlString] userInfo:nil  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (operation.response.statusCode != 200) {
            if (fBlock) {
                
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                [userInfo setObject:[NSNumber numberWithInt:operation.response.statusCode] forKey:@"statusCode"];
                
                NSError *error = [NSError errorWithDomain:@"http result error" code:GJCFHttpNo200Error userInfo:userInfo];
                fBlock(error);
            }
        }
        if (sBlock) {
            sBlock(responseObject);
        }
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.requestDict removeObjectForKey:[NSNumber numberWithUnsignedInteger:operation.hash]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fBlock) {
            fBlock(error);
        }
        
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.requestDict removeObjectForKey:[NSNumber numberWithUnsignedInteger:operation.hash]];
        }
    }];
    
    
    [requestDict setObject:operation forKey:[NSNumber numberWithUnsignedInteger:operation.hash]];
    return operation.hash;
}

- (NSUInteger)requestPostData:(NSString *)urlString header:(NSMutableDictionary *)header bodyData:(NSData *)bodyData responseType:(GJCFHttpResponseType)responseType sBlock:(GJCFHttpSuccessBlock)sBlock fBlock:(GJCFHttpFailBlock)fBlock pBlock:(GJCFHttpPrograssBlock)pBlock
{
    if(urlString == nil || urlString.length == 0)
    {
        if (fBlock) {
            
            NSError *error = [NSError errorWithDomain:@"传入错误的参数" code:GJCFHttpParamError userInfo:nil];
            fBlock(error);
        }
        return 0;
    }
    
    [self.httpClient gjcf_clearDefaultHeaders];
    
    NSArray *keys = [header allKeys];
    for (NSString *key in keys) {
        [self.httpClient setDefaultHeader:key value:[header objectForKey:key]];
    }
    
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperation *operation = [self.httpClient gjcf_postWithUrl:[NSURL URLWithString:urlString] databody:bodyData userInfo:nil uploadProgressBlock:pBlock success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode != 200) {
            if (fBlock) {
                
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                [userInfo setObject:[NSNumber numberWithInt:operation.response.statusCode] forKey:@"statusCode"];
                
                NSError *error = [NSError errorWithDomain:@"http result error" code:GJCFHttpNo200Error userInfo:userInfo];
                fBlock(error);
            }
        }
        if (sBlock) {
            sBlock(responseObject);
        }
        
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.requestDict removeObjectForKey:[NSNumber numberWithUnsignedInteger:operation.hash]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fBlock) {
            fBlock(error);
        }
        
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.requestDict removeObjectForKey:[NSNumber numberWithUnsignedInteger:operation.hash]];
        }
    }];
    
    [requestDict setObject:operation forKey:[NSNumber numberWithUnsignedInteger:operation.hash]];
    return operation.hash;
}

- (NSUInteger)requestGetImageUrl:(NSString *)urlString header:(NSMutableDictionary *)header sBlock:(GJCFHttpSuccessBlock)sBlock fBlock:(GJCFHttpFailBlock)fBlock pBlock:(GJCFHttpPrograssBlock)pBlock
{
    if(urlString == nil || urlString.length == 0)
    {
        if (fBlock) {
            
            NSError *error = [NSError errorWithDomain:@"传入错误的参数" code:GJCFHttpParamError userInfo:nil];
            fBlock(error);
        }
        return 0;
    }
    
    [self.httpClient gjcf_clearDefaultHeaders];
    
    NSArray *keys = [header allKeys];
    for (NSString *key in keys) {
        [self.httpClient setDefaultHeader:key value:[header objectForKey:key]];
    }
    
    
    NSURLRequest *request =  [self.httpClient requestWithMethod:@"GET" path:urlString parameters:nil];
    
    
    __weak typeof(self) weakSelf = self;
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setDownloadProgressBlock:pBlock];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode != 200) {
            if (fBlock) {
                
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                [userInfo setObject:[NSNumber numberWithInt:operation.response.statusCode] forKey:@"statusCode"];
                
                NSError *error = [NSError errorWithDomain:@"http result error" code:GJCFHttpNo200Error userInfo:userInfo];
                fBlock(error);
            }
            
            
        }
        if (sBlock) {
            sBlock(responseObject);
        }
        
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.requestDict removeObjectForKey:[NSNumber numberWithUnsignedInteger:operation.hash]];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fBlock) {
            fBlock(error);
        }
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.requestDict removeObjectForKey:[NSNumber numberWithUnsignedInteger:operation.hash]];
        }
        
    }];
    
    
    
    
    [self.httpClient enqueueHTTPRequestOperation:operation];
    
    [requestDict setObject:operation forKey:[NSNumber numberWithUnsignedInteger:operation.hash]];
    
    return operation.hash;
}

- (void)cancelAllRequest
{
    for (NSOperation *operation in [self.httpClient.operationQueue operations])
    {
        [operation cancel];
    }
    
    [self.requestDict removeAllObjects];
}

- (void)cancelRequestByRequestId:(NSUInteger)requestId
{
    AFHTTPRequestOperation *operation = [self.requestDict objectForKey:[NSNumber numberWithUnsignedInteger:requestId]];
    if (operation) {
        [operation cancel];
        [self.requestDict removeObjectForKey:[NSNumber numberWithUnsignedInteger:requestId]];
    }
    
}

- (AFHTTPRequestOperation *)operationByRequestId:(NSUInteger)requestId
{
    AFHTTPRequestOperation *operation = [self.requestDict objectForKey:[NSNumber numberWithUnsignedInteger:requestId]];
    
    
    return operation;
}
@end
