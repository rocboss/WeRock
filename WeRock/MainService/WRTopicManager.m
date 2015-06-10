//
//  WRTopicManager.m
//  WeRock
//
//  Created by ZYVincent on 15/4/28.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRTopicManager.h"

@implementation WRTopicManager

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)getHomeTopic:(WRConditionModel *)condition  withResult:(WRTopicManagerResultListBlock)resultBlock
{
    WRHttpTask *task = [WRHttpTask taskWithRequestType:WRHttpRequestTypeHomeIndex];
    task.postParams = @{
                        @"pageIndex":@(condition.pageIndex),
                        @"type":condition.topicSortType,
                        };
    
    [task setResultBlock:^(WRHttpTask *task, WRHttpResponse *response) {
       
        NSMutableArray *resultArray = [NSMutableArray array];
        for (NSDictionary *topicDict in response.dataResult) {
            
            WRTopicModel *topic = [[WRTopicModel alloc]initWithDictionary:topicDict];
            [resultArray addObject:topic];
        }
        
        if (resultBlock) {
            resultBlock(response.status,resultArray,response.errorMsg);
        }
        
    }];
    
    [[WRHttpRequestManager shareManager] addTask:task];
}

- (void)postTopic:(WRTopicModel *)topic withResult:(WRTopicManagerResultOperationBlock)resultBlock
{
    WRHttpTask *task = [WRHttpTask taskWithRequestType:WRHttpRequestTypeDoPostTopic];
    task.requestType = WRHttpRequestTypeDoPostTopic;
    task.postParams = @{
                        @"title":topic.title,
                        @"msg":topic.content,
                        @"tag":[topic tagArrayString],
                        @"client":@"iPhone客户端",
                        };
    [task setResultBlock:^(WRHttpTask *task, WRHttpResponse *response) {
       
        if (resultBlock) {
            resultBlock(response.status,response.errorMsg);
        }
        
    }];
    
    [[WRHttpRequestManager shareManager] addTask:task];
}

- (void)getHotTagsWithResult:(WRTopicManagerResultListBlock)resultBlock
{
    WRHttpTask *task = [WRHttpTask taskWithRequestType:WRHttpRequestTypeHomeGetHotTags];
    [task setResultBlock:^(WRHttpTask *task, WRHttpResponse *response) {
        
        NSLog(@"热门标签 :%@",response.dataResult);
        
    }];
    
    [[WRHttpRequestManager shareManager]addTask:task];
}

- (void)searchTopic:(WRConditionModel *)condition withResult:(WRTopicManagerResultListBlock)resultBlock
{
    
}

- (void)getHotTopic:(WRConditionModel *)condition withResult:(WRTopicManagerResultListBlock)resultBlock
{
    
}

- (void)getTagTopic:(WRConditionModel *)condition withResult:(WRTopicManagerResultListBlock)resultBlock
{
    
}

- (void)getTopicDetail:(WRTopicModel *)topic withResult:(WRTopicManagerResultListBlock)resultBlock
{
    WRHttpTask *task = [WRHttpTask taskWithRequestType:WRHttpRequestTypeHomeRead];
    task.postParams = @{
                        @"tid":topic.tid,
                        };
    [task setResultBlock:^(WRHttpTask *task, WRHttpResponse *response) {
        
        NSArray *dataResult = response.dataResult;
        
        WRTopicModel *topic = [[WRTopicModel alloc]initWithDictionary:[dataResult firstObject]];
        
        if (resultBlock) {
            resultBlock(response.status,@[topic],response.errorMsg);
        }
        
    }];
    
    [[WRHttpRequestManager shareManager] addTask:task];
}

- (void)getTopicReplyList:(WRTopicModel *)topic withCondition:(WRConditionModel *)condition withResult:(WRTopicManagerResultListBlock)resultBlock
{
    WRHttpTask *task = [WRHttpTask taskWithRequestType:WRHttpRequestTypeHomeGetReplyList];
    task.postParams = @{
                        @"tid":topic.tid,
                        @"pageIndex":@(condition.pageIndex),
                        };
    [task setResultBlock:^(WRHttpTask *task, WRHttpResponse *response) {
        
        NSArray *dataResult = response.dataResult;
        
        if (resultBlock) {
            resultBlock(response.status,dataResult,response.errorMsg);
        }
        
    }];
    
    [[WRHttpRequestManager shareManager] addTask:task];
}

- (void)getTopicReplyFloorList:(WRTopicReplyModel *)reply  withCondition:(WRConditionModel *)condition withResult:(WRTopicManagerResultListBlock)resultBlock
{
    WRHttpTask *task = [WRHttpTask taskWithRequestType:WRHttpRequestTypeHomeGetReplyFloorList];
    task.postParams = @{
                        @"pid":reply.pid,
                        @"pageIndex":@(condition.pageIndex),
                        };
    [task setResultBlock:^(WRHttpTask *task, WRHttpResponse *response) {
        
        NSArray *dataResult = response.dataResult;
        
        if (resultBlock) {
            resultBlock(response.status,dataResult,response.errorMsg);
        }
        
    }];
    
    [[WRHttpRequestManager shareManager] addTask:task];

}

- (void)favoriteTopic:(WRTopicModel *)topic withResult:(WRTopicManagerResultOperationBlock)resultBlock
{
    
}

- (void)praiseTopic:(WRTopicModel *)topic withResult:(WRTopicManagerResultOperationBlock)resultBlock
{
    
}

- (void)lockTopic:(WRTopicModel *)topic withResult:(WRTopicManagerResultOperationBlock)resultBlock
{
    
}

- (void)topTopic:(WRTopicModel *)topic withResult:(WRTopicManagerResultOperationBlock)resultBlock
{
    
}

- (void)replyTopic:(WRTopicModel *)topic withReply:(WRTopicReplyModel *)reply withResult:(WRTopicManagerResultOperationBlock)resultBlock
{
    
}

- (void)floorReply:(WRTopicReplyModel *)reply withFloor:(WRTopicReplyFloorModel *)floor withResult:(WRTopicManagerResultOperationBlock)resultBlock
{
    
}

- (void)getUserFavoriteTopicList:(WRUserModel *)user withResult:(WRTopicManagerResultListBlock)resultBlock
{
    
}

- (void)getUserPostTopicList:(WRUserModel *)user withResult:(WRTopicManagerResultListBlock)resultBlock
{
    
}

- (void)getUserReplyList:(WRUserModel *)user withResult:(WRTopicManagerResultListBlock)resultBlock
{
    
}

@end
