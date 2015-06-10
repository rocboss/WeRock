//
//  WRHttpRequestManager.h
//  WeRock
//
//  Created by ZYVincent on 15/4/27.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WRHttpTask.h"

#define WRHttpRequestProgressErrorCode 99999

@interface WRHttpRequestManager : NSObject

+ (WRHttpRequestManager *)shareManager;

/**
 *  当前登录用户Id
 *
 *  @return
 */
- (NSString *)currentLoginUserId;

/**
 *  最大并行执行的请求数量
 *
 *  @param maxCount
 */
- (void)setMaxConcurrenceRequestCount:(NSInteger)maxCount;

/**
 *  设置默认的post参数
 *
 *  @param postParams
 */
- (void)addDefaultPostParams:(NSDictionary *)postParams;

/**
 *  添加任务
 *
 *  @param task
 */
- (void)addTask:(WRHttpTask *)aTask;

/**
 *  取消任务
 *
 *  @param taskIdentifier
 */
- (void)cancelTaskByIdentifier:(NSString *)taskIdentifier;

/**
 *  退出并清除任务
 *
 *  @param taskIdentifier
 */
- (void)cancelRemoveTaskByIdentifier:(NSString *)taskIdentifier;

@end
