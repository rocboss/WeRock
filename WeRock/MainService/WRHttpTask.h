//
//  WRHttpTask.h
//  WeRock
//
//  Created by ZYVincent on 15/4/27.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WRHttpConstants.h"
#import "WRHttpResponse.h"

@class WRHttpTask;

typedef void (^WRHttpRequestResultBlock) (WRHttpTask *task, WRHttpResponse *response);

/**
 *  请求状态
 */
typedef NS_ENUM(NSUInteger, WRHttpRequestStatus) {
    /**
     *  请求中
     */
    WRHttpRequestStatusRequesting,
    /**
     *  等待执行
     */
    WRHttpRequestStatusWaiting,
    /**
     *  退出请求了
     */
    WRHttpRequestStatusCanceled,
    /**
     *  失败了
     */
    WRHttpRequestStatusFaild,
    /**
     *  成功了
     */
    WRHttpRequestStatusSuccess,
};

@interface WRHttpTask : NSObject

/**
 *  唯一标示
 */
@property (nonatomic,readonly)NSString *identifier;

/**
 *  优先级，数字越小，优先级越高
 */
@property (nonatomic,assign)NSInteger priority;

/**
 *  任务状态
 */
@property (nonatomic,assign)WRHttpRequestStatus status;

/**
 *  默认为YES
 */
@property (nonatomic,assign)BOOL isAutoRemoveWhileFaild;

/**
 *  默认为YES
 */
@property (nonatomic,assign)BOOL isAutoRemoveWhileCanceled;

/**
 *  请求类型
 */
@property (nonatomic,assign)WRHttpRequestType requestType;

/**
 *  post参数
 */
@property (nonatomic,strong)NSDictionary *postParams;

/**
 *  get参数
 */
@property (nonatomic,strong)NSDictionary *getParams;

/**
 *  请求类型
 */
@property (nonatomic,strong)NSString *httpMethod;

/**
 *  用户自定义携带信息
 */
@property (nonatomic,strong)NSDictionary *userInfo;

/**
 *  结果回调
 */
@property (nonatomic,copy)WRHttpRequestResultBlock resultBlock;

+ (WRHttpTask *)taskWithRequestType:(WRHttpRequestType)type;

- (void)setResultBlock:(WRHttpRequestResultBlock)resultBlock;

/**
 *  是否合法任务
 *
 *  @return
 */
- (BOOL)isValidateTask;

/**
 *  任务是否相同
 *
 *  @param task
 *
 *  @return 
 */
- (BOOL)isEqual:(WRHttpTask *)task;

@end
