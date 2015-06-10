//
//  WRUserCenter.m
//  WeRock
//
//  Created by ZYVincent on 15/4/27.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRUserCenter.h"
#import "WRHttpRequestManager.h"
#import "Base64.h"
#import "WRTopicManager.h"

@implementation WRUserCenter

- (void)registUser:(WRUserModel *)aUser withResult:(WRUserCenterRequestOperationBlock)resultBlock
{
    WRHttpTask *task = [WRHttpTask taskWithRequestType:WRHttpRequestTypeUserRegist];
    task.postParams = @{
                        @"nickname":aUser.userName,
                        @"password":aUser.password,
                        @"email":aUser.email,
                        };
    [task setResultBlock:^(WRHttpTask *task, WRHttpResponse *response) {
        if (resultBlock) {
            resultBlock(response.status,response.errorMsg);
        }
    }];
    [[WRHttpRequestManager shareManager] addTask:task];
}

- (void)loginUser:(WRUserModel *)aUser withResult:(WRUserCenterRequestReultListBlock)resultBlock
{
    WRHttpTask *task = [WRHttpTask taskWithRequestType:WRHttpRequestTypeUserLogin];
    task.postParams = @{
                        @"password":aUser.password,
                        @"email":aUser.email,
                        };
    [task setResultBlock:^(WRHttpTask *task, WRHttpResponse *response) {
        
        if (resultBlock) {
            
            WRUserModel *userModel = [[WRUserModel alloc]initWithUserInfo:response.dataResult];
            
            [self setToken:userModel.token userId:userModel.userId groupId:userModel.groupId];
            
            resultBlock(response.status,@[userModel],response.errorMsg);
        }
        
    }];
    [[WRHttpRequestManager shareManager] addTask:task];
}

- (void)getUserDetail:(WRUserModel *)aUser withResult:(WRUserCenterRequestReultListBlock)resultBlock
{
    WRHttpTask *task = [WRHttpTask taskWithRequestType:WRHttpRequestTypeUserDetail];
    task.postParams = @{
                        @"userId":aUser.userId,
                        };
    [task setResultBlock:^(WRHttpTask *task, WRHttpResponse *response) {
        
        NSMutableArray *resultArray = [NSMutableArray array];

        if (response.responseType == WRHttpResponseTypeSuccess) {
            
            if ([aUser.userId isEqualToString:[[WRHttpRequestManager shareManager] currentLoginUserId]]) {
                
                WRUserModel *myInfo = [[WRUserModel alloc]initWithMyDetailInfo:response.dataResult];
                
                [resultArray addObject:myInfo];
                
            }else{
                
                WRUserModel *otherInfo = [[WRUserModel alloc]initWithUserDetailInfo:response.dataResult];
                
                [resultArray addObject:otherInfo];
            }
            
        }
        
        if (resultBlock) {
            resultBlock(response.status,resultArray,response.errorMsg);
        }
        
    }];
    [[WRHttpRequestManager shareManager]addTask:task];
}

- (void)setToken:(NSString *)token userId:(NSString *)userId groupId:(NSString *)groupId
{
    [[WRHttpRequestManager shareManager] addDefaultPostParams:@{@"token":token}];
    [[WRHttpRequestManager shareManager] addDefaultPostParams:@{@"loginUserId":userId}];
    [[WRHttpRequestManager shareManager] addDefaultPostParams:@{@"groupId":groupId}];
    
//    WRConditionModel *whisperCondition = [[WRConditionModel alloc]init];
//    whisperCondition.status = 0 ;
//    [self getUserWhispersWithCondition:whisperCondition withResult:^(BOOL status, NSArray *resultModelArray, NSString *msg) {
//        
//    }];
//    
//    WRUserModel *aUser = [[WRUserModel alloc]init];
//    aUser.userId = @"1";
//    [self getUserDetail:aUser withResult:^(BOOL status, NSArray *resultModelArray, NSString *msg) {
//        
//    }];
//    aUser.userId = userId;
//    [self getUserDetail:aUser withResult:^(BOOL status, NSArray *resultModelArray, NSString *msg) {
//        
//    }];
//    [self getTopSignUserWithResult:^(BOOL status, NSArray *resultModelArray, NSString *msg) {
//        
//    }];
//    
//    aUser.userId = @"2";
//    [self lockUser:aUser withResult:^(BOOL status, NSString *msg) {
//        
//    }];
//
//    aUser.userId = [[WRHttpRequestManager shareManager] currentLoginUserId];
//    WRConditionModel *condition = [[WRConditionModel alloc]init];
//    [self getUserFollows:aUser withCondition:condition withResult:^(BOOL status, NSArray *resultModelArray, NSString *msg) {
//        
//    }];
//    [self getUserFans:aUser withCondition:condition withResult:^(BOOL status, NSArray *resultModelArray, NSString *msg) {
//        
//    }];
//    
//    WRWhisperModel *whisper = [[WRWhisperModel alloc]init];
//    whisper.recvUserId = @"1";
//    whisper.content = @"测试从手机客户端发出来的私信";
//    [self whisperUserWithCondition:whisper withResult:^(BOOL status, NSString *msg) {
//        
//    }];
}

- (void)followUser:(WRUserModel *)aUser withResult:(WRUserCenterRequestOperationBlock)resultBlock
{
    WRHttpTask *task = [WRHttpTask taskWithRequestType:WRHttpRequestTypeDoFollow];
    task.postParams = @{
                        @"uid":aUser.userId,
                        };
    [task setResultBlock:^(WRHttpTask *task, WRHttpResponse *response) {
       
        resultBlock(response.status,response.errorMsg);

    }];
    [[WRHttpRequestManager shareManager]addTask:task];
}

- (void)whisperUserWithCondition:(WRWhisperModel *)whisper withResult:(WRUserCenterRequestOperationBlock)resultBlock
{
    WRHttpTask *task = [WRHttpTask taskWithRequestType:WRHttpRequestTypeDoDeliverWhisper];
    task.postParams = @{
                        @"atuid":whisper.recvUserId,
                        @"content":whisper.content,
                      };
    [task setResultBlock:^(WRHttpTask *task, WRHttpResponse *response) {
        
        if (resultBlock) {
            resultBlock(response.status,response.errorMsg);
        }
    }];
    [[WRHttpRequestManager shareManager]addTask:task];
}

- (void)lockUser:(WRUserModel *)aUser withResult:(WRUserCenterRequestOperationBlock)resultBlock
{
    WRHttpTask *task = [WRHttpTask taskWithRequestType:WRHttpRequestTypeAdminLockUser];
    task.postParams = @{
                        @"userId":aUser.userId,
                        @"status":@(aUser.isLock),
                        };
    [task setResultBlock:^(WRHttpTask *task, WRHttpResponse *response) {
        
        if (resultBlock) {
            resultBlock(response.status,response.errorMsg);
        }
        
    }];
    [[WRHttpRequestManager shareManager]addTask:task];
}

- (void)getTopSignUserWithResult:(WRUserCenterRequestReultListBlock)resultBlock
{
    WRHttpTask *task = [WRHttpTask taskWithRequestType:WRHttpRequestTypeHomeGetTodayTopSign];
    task.postParams = @{};
    [task setResultBlock:^(WRHttpTask *task, WRHttpResponse *response) {
        if (resultBlock) {
            
            NSMutableArray *resultArray = [NSMutableArray array];
            
            for (NSDictionary *userDict in response.dataResult) {
                
                WRUserModel *user = [[WRUserModel alloc]initWithHotSignInfo:userDict];
                
                [resultArray addObject:user];
            }
            
            resultBlock(response.status,resultArray,response.errorMsg);
        }
    }];
    [[WRHttpRequestManager shareManager]addTask:task];
}

- (void)getUserFans:(WRUserModel *)aUser withCondition:(WRConditionModel *)condition withResult:(WRUserCenterRequestReultListBlock)resultBlock
{
    WRHttpTask *task = [WRHttpTask taskWithRequestType:WRHttpRequestTypeUserFans];
    task.postParams = @{
                        @"userId":aUser.userId,
                        @"pageIndex":@(condition.pageIndex),
                        };
    [task setResultBlock:^(WRHttpTask *task, WRHttpResponse *response) {
        
        NSMutableArray *resultArray = [NSMutableArray array];
        
        for (NSDictionary *userDict in response.dataResult) {
            
            WRUserModel *user = [[WRUserModel alloc]initWithUserInfo:userDict];
            
            [resultArray addObject:user];
        }
        
        resultBlock(response.status,resultArray,response.errorMsg);
        
    }];
    [[WRHttpRequestManager shareManager]addTask:task];
}

- (void)getUserFollows:(WRUserModel *)aUser withCondition:(WRConditionModel *)condition withResult:(WRUserCenterRequestReultListBlock)resultBlock
{
    WRHttpTask *task = [WRHttpTask taskWithRequestType:WRHttpRequestTypeUserFollow];
    task.postParams = @{
                        @"userId":aUser.userId,
                        @"pageIndex":@(condition.pageIndex),
                        };
    [task setResultBlock:^(WRHttpTask *task, WRHttpResponse *response) {
       
        NSMutableArray *resultArray = [NSMutableArray array];
        
        for (NSDictionary *userDict in response.dataResult) {
            
            WRUserModel *user = [[WRUserModel alloc]initWithUserInfo:userDict];
            
            [resultArray addObject:user];
        }
        
        resultBlock(response.status,resultArray,response.errorMsg);
        
    }];
    [[WRHttpRequestManager shareManager]addTask:task];
}

- (void)getUserWhispersWithCondition:(WRConditionModel *)condition withResult:(WRUserCenterRequestReultListBlock)resultBlock
{
    WRHttpTask *task = [WRHttpTask taskWithRequestType:WRHttpRequestTypeUserWhisper];
    task.postParams = @{
                        @"status":@(condition.status),
                        @"pageIndex":@(condition.pageIndex),
                        };
    [task setResultBlock:^(WRHttpTask *task, WRHttpResponse *response) {
        
        NSMutableArray *resultArray = [NSMutableArray array];
        
        for (NSDictionary *whisperDict in response.dataResult) {
            
            
        }
        
    }];
    [[WRHttpRequestManager shareManager]addTask:task];
}

- (void)searchUser:(WRConditionModel *)condition withResult:(WRUserCenterRequestReultListBlock)resultBlock
{
    
}

- (void)registUserDevice:(WRUserModel *)aUser withResult:(WRUserCenterRequestOperationBlock)resultBlock
{
    
}

@end
