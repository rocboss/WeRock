//
//  WRHttpTask.m
//  WeRock
//
//  Created by ZYVincent on 15/4/27.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRHttpTask.h"

@interface WRHttpTask ()

@property (nonatomic,strong)NSMutableArray *observers;

@end

@implementation WRHttpTask

+ (WRHttpTask *)taskWithRequestType:(WRHttpRequestType)type
{
    WRHttpTask *task = [[WRHttpTask alloc]init];
    task.requestType = type;
    
    return task;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        self.priority = 0;
        self.status = WRHttpRequestStatusWaiting;
        self.requestType = WRHttpRequestTypeUndeifne;
        self.isAutoRemoveWhileCanceled = YES;
        self.isAutoRemoveWhileFaild = YES;
        self.observers = [[NSMutableArray alloc]init];
        _identifier = [NSString stringWithFormat:@"WRHttpTask_%@",GJCFStringCurrentTimeStamp];
        self.httpMethod = @"POST";
    }
    return self;
}

- (BOOL)isValidateTask
{
    return self.postParams != nil && self.requestType != WRHttpRequestTypeUndeifne;
}

- (BOOL)isEqual:(WRHttpTask *)task
{
    return self.postParams == task.postParams && self.requestType == task.requestType;

}

@end
