//
//  WRUserCenter.h
//  WeRock
//
//  Created by ZYVincent on 15/4/27.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WRUserModel.h"
#import "WRConditionModel.h"
#import "WRWhisperModel.h"

typedef void (^WRUserCenterRequestReultListBlock) (BOOL status,NSArray *resultModelArray,NSString *msg);

typedef void (^WRUserCenterRequestOperationBlock) (BOOL status,NSString *msg);


@interface WRUserCenter : NSObject

- (void)registUser:(WRUserModel *)aUser withResult:(WRUserCenterRequestOperationBlock)resultBlock;

- (void)loginUser:(WRUserModel *)aUser withResult:(WRUserCenterRequestReultListBlock)resultBlock;

- (void)getUserDetail:(WRUserModel *)aUser withResult:(WRUserCenterRequestReultListBlock)resultBlock;

- (void)followUser:(WRUserModel *)aUser withResult:(WRUserCenterRequestOperationBlock)resultBlock;

- (void)whisperUserWithCondition:(WRWhisperModel *)whisper withResult:(WRUserCenterRequestOperationBlock)resultBlock;

- (void)lockUser:(WRUserModel *)aUser withResult:(WRUserCenterRequestOperationBlock)resultBlock;

- (void)getTopSignUserWithResult:(WRUserCenterRequestReultListBlock)resultBlock;

- (void)getUserFans:(WRUserModel *)aUser withCondition:(WRConditionModel *)condition withResult:(WRUserCenterRequestReultListBlock)resultBlock;

- (void)getUserFollows:(WRUserModel *)aUser withCondition:(WRConditionModel *)condition withResult:(WRUserCenterRequestReultListBlock)resultBlock;

- (void)getUserWhispersWithCondition:(WRConditionModel *)condition withResult:(WRUserCenterRequestReultListBlock)resultBlock;

- (void)searchUser:(WRConditionModel *)condition withResult:(WRUserCenterRequestReultListBlock)resultBlock;

- (void)registUserDevice:(WRUserModel *)aUser withResult:(WRUserCenterRequestOperationBlock)resultBlock;

@end
