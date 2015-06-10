//
//  WRHttpRequestManager.m
//  WeRock
//
//  Created by ZYVincent on 15/4/27.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRHttpRequestManager.h"
#import "NSDictionary+UrlEncodedString.h"


@interface WRHttpRequestManager ()

@property (nonatomic,strong)dispatch_queue_t requestQueue;

@property (nonatomic,strong)NSMutableArray *requestPool;

@property (nonatomic,assign)NSInteger maxRequestCount;

@property (nonatomic,strong)AFHTTPClient *httpClient;

@property (nonatomic,strong)NSMutableDictionary *defaultPostParams;

@property (nonatomic,assign)NSInteger requestingCount;

@end

@implementation WRHttpRequestManager

+ (WRHttpRequestManager *)shareManager
{
    static WRHttpRequestManager *_manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _manager = [[self alloc]init];
    });
    
    return _manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        self.requestQueue = dispatch_queue_create("WRHttpRequestManagerTaskQueue", DISPATCH_QUEUE_SERIAL);
        self.requestPool = [[NSMutableArray alloc]init];
        self.defaultPostParams = [[NSMutableDictionary alloc]init];
        self.maxRequestCount = 6;
        self.requestingCount = 0;
        self.httpClient = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:WRServerHost]];
        [self.httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/json",@"text/javascript",@"application/json",@"text/html",@"application/xhtml+xml",@"*/*",@"application/xhtml+xml",@"image/webp", nil]];
        self.httpClient.stringEncoding = NSUTF8StringEncoding;
        self.httpClient.parameterEncoding = AFFormURLParameterEncoding;
    
    }
    return self;
}

- (NSString *)currentLoginUserId
{
    return [self.defaultPostParams objectForKey:@"loginUserId"];
}

- (void)setMaxConcurrenceRequestCount:(NSInteger)maxCount
{
    self.maxRequestCount = maxCount;
}

- (void)addDefaultPostParams:(NSDictionary *)postParams
{
    if (!postParams || postParams.count == 0) {
        return;
    }
    
    [self.defaultPostParams addEntriesFromDictionary:postParams];
}

/**
 *  添加任务
 *
 *  @param task
 */
- (void)addTask:(WRHttpTask *)aTask
{
    if (GJCFCheckObjectNull(aTask)) {
        return;
    }
    
    if (![aTask isValidateTask]) {
        NSLog(@"request task is not validate :%@",aTask.identifier);
        return;
    }
    
    [self.requestPool addObject:aTask];
    
    [self createHttpRequestWithTask:aTask];
}

/**
 *  取消任务
 *
 *  @param taskIdentifier
 */
- (void)cancelTaskByIdentifier:(NSString *)taskIdentifier
{
    if (GJCFStringIsNull(taskIdentifier)) {
        return;
    }
    
    [self cancelTask:taskIdentifier shouldRemove:NO];
}

/**
 *  退出并清除任务
 *
 *  @param taskIdentifier
 */
- (void)cancelRemoveTaskByIdentifier:(NSString *)taskIdentifier
{
    if (GJCFStringIsNull(taskIdentifier)) {
        return;
    }
    
    [self cancelTask:taskIdentifier shouldRemove:YES];
}

- (void)cancelTask:(NSString *)aTaskIdentifier shouldRemove:(BOOL)remove
{
    [self performMethodInQueue:^{
       
        /* 推出请求 */
        [self.httpClient.operationQueue.operations enumerateObjectsUsingBlock:^(AFHTTPRequestOperation *operation, NSUInteger idx, BOOL *stop) {
            
            WRHttpTask *destTask = [operation.userInfo objectForKey:@"task"];
            
            if ([destTask.identifier isEqualToString:aTaskIdentifier]) {
                
                [operation cancel];
                
                *stop = YES;
            }
            
        }];
        
        /* 更新任务状态 */
        [self updateTask:aTaskIdentifier withState:WRHttpRequestStatusCanceled];
        
        if (remove) {
            
            /* 移除任务 */
            for (WRHttpTask *task in self.requestPool) {
                
                if ([task.identifier isEqual:aTaskIdentifier]) {
                    
                    [self.requestPool removeObject:task];
                    
                    break;
                }
            }
        }
        
    }];
}

#pragma mark - 内部使用AFHttpRequest实现请求

- (void)performMethodInQueue:(void(^)(void))task
{
    dispatch_async(self.requestQueue, task);
}

- (void)createHttpRequestWithTask:(WRHttpTask *)aTask
{
    GJCFWeakSelf weakSelf = self;

    if (aTask.postParams) {
        
        NSMutableDictionary *postParams = [NSMutableDictionary dictionaryWithDictionary:aTask.postParams];
        [postParams addEntriesFromDictionary:self.defaultPostParams];
        aTask.postParams = postParams;
        
    }
    
    [self.httpClient postPath:[WRHttpConstants requestTypeToInterface:aTask.requestType] parameters:aTask.postParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [weakSelf performMethodInQueue:^{
            
            NSDictionary *resultJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            NSDictionary *resultDict = @{@"result":resultJson};
            
            [weakSelf task:aTask success:resultDict];
            
            /* 更新任务状态 */
            [weakSelf updateTask:aTask.identifier withState:WRHttpRequestStatusSuccess];
            
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [weakSelf performMethodInQueue:^{
            
            /* 更新任务状态 */
            [weakSelf updateTask:aTask.identifier withState:WRHttpRequestStatusFaild];
            
            [weakSelf task:aTask faild:error];
            
        }];
        
    } progress:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
        CGFloat uploadKbSize = totalBytesWritten/1024.0f;
        CGFloat totoalSize = totalBytesExpectedToWrite/1024.0f;
        CGFloat uploadProgressValue = (uploadKbSize/1024.f)/(totoalSize/1024.f);
        
//        [self task:aTask progress:uploadProgressValue];

    }];
    
    [self updateTask:aTask.identifier withState:WRHttpRequestStatusRequesting];
}

- (void)task:(WRHttpTask *)task success:(NSDictionary *)responseInfo
{
    NSDictionary *result = [responseInfo objectForKey:@"result"];
    
    NSLog(@"WRHttpRequest begin for task:%@ success:%@ msg:%@",task,result,result[@"msg"]);

    WRHttpResponse *response = [[WRHttpResponse alloc]init];
    response.responseType = WRHttpResponseTypeSuccess;
    response.status = [[result objectForKey:@"status"] intValue] == 0;
    response.errorMsg = [result objectForKey:@"msg"];
    response.dataResult = [result objectForKey:@"data"];
    response.errorCode = [[result objectForKey:@"status"] intValue];
    
    [self dispatchResultWithTask:task withResponse:response];
}

- (void)task:(WRHttpTask *)task progress:(CGFloat)progress
{
    NSLog(@"WRHttpRequest begin for task:%@ progress:%f",task,progress);

    WRHttpResponse *response = [[WRHttpResponse alloc]init];
    response.status = YES;
    response.errorMsg = @"显示请求进度";
    response.errorCode = WRHttpRequestProgressErrorCode;
    response.dataResult = nil;
    response.progress = progress;
    response.responseType = WRHttpResponseTypeProgress;
    
    [self dispatchResultWithTask:task withResponse:response];
}

- (void)task:(WRHttpTask *)task faild:(NSError*)error
{
    NSLog(@"WRHttpRequest begin for task:%@ error:%@",task,error);

    WRHttpResponse *response = [[WRHttpResponse alloc]init];
    response.responseType = WRHttpResponseTypeFaild;
    response.status = NO;
    response.errorMsg = @"网络链接错误";
    response.errorCode = NSIntegerMax;
    response.dataResult = nil;
    
    [self dispatchResultWithTask:task withResponse:response];
}

- (void)dispatchResultWithTask:(WRHttpTask *)aTask withResponse:(WRHttpResponse *)response
{
    if (aTask.resultBlock) {
        aTask.resultBlock(aTask,response);
    }
    
    [self.requestPool removeObject:aTask];
}

- (void)updateTask:(NSString*)aTaskIdentifier withState:(WRHttpRequestStatus)status
{
    for (int i = 0 ; i < self.requestPool.count ; i++) {
        
        WRHttpTask *task = [self.requestPool objectAtIndex:i];
        
        if ([task.identifier isEqual:aTaskIdentifier]) {
            
            if (task.status == WRHttpRequestStatusRequesting && status != WRHttpRequestStatusRequesting) {
                self.requestingCount -- ;
            }
            
            if (task.status != WRHttpRequestStatusRequesting && status == WRHttpRequestStatusRequesting) {
                self.requestingCount ++ ;
            }
            
            task.status = status;
            
            [self.requestPool replaceObjectAtIndex:i withObject:task];
            
            break;
        }
        
    }
}

@end
