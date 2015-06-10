//
//  WRTopicManager.h
//  WeRock
//
//  Created by ZYVincent on 15/4/28.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WRConditionModel.h"
#import "WRHttpRequestManager.h"
#import "WRTopicModel.h"
#import "WRTopicReplyModel.h"
#import "WRTopicReplyFloorModel.h"
#import "WRTopicTagModel.h"
#import "WRUserModel.h"

typedef void (^WRTopicManagerResultListBlock) (BOOL status, NSArray *resultModelArray , NSString *msg);

typedef void (^WRTopicManagerResultOperationBlock) (BOOL status , NSString *msg);

@interface WRTopicManager : NSObject

- (void)getHotTagsWithResult:(WRTopicManagerResultListBlock)resultBlock;

- (void)searchTopic:(WRConditionModel *)condition withResult:(WRTopicManagerResultListBlock)resultBlock;

- (void)getHotTopic:(WRConditionModel *)condition withResult:(WRTopicManagerResultListBlock)resultBlock;

- (void)getTagTopic:(WRConditionModel *)condition withResult:(WRTopicManagerResultListBlock)resultBlock;

- (void)getHomeTopic:(WRConditionModel *)condition withResult:(WRTopicManagerResultListBlock)resultBlock;

- (void)getTopicDetail:(WRTopicModel *)topic withResult:(WRTopicManagerResultListBlock)resultBlock;

- (void)getTopicReplyList:(WRTopicModel *)topic withCondition:(WRConditionModel *)condition withResult:(WRTopicManagerResultListBlock)resultBlock;

- (void)getTopicReplyFloorList:(WRTopicReplyModel *)reply withCondition:(WRConditionModel *)condition withResult:(WRTopicManagerResultListBlock)resultBlock;

- (void)postTopic:(WRTopicModel *)topic withResult:(WRTopicManagerResultOperationBlock)resultBlock;

- (void)favoriteTopic:(WRTopicModel *)topic withResult:(WRTopicManagerResultOperationBlock)resultBlock;

- (void)praiseTopic:(WRTopicModel *)topic withResult:(WRTopicManagerResultOperationBlock)resultBlock;

- (void)lockTopic:(WRTopicModel *)topic withResult:(WRTopicManagerResultOperationBlock)resultBlock;

- (void)topTopic:(WRTopicModel *)topic withResult:(WRTopicManagerResultOperationBlock)resultBlock;

- (void)replyTopic:(WRTopicModel *)topic withReply:(WRTopicReplyModel *)reply withResult:(WRTopicManagerResultOperationBlock)resultBlock;

- (void)floorReply:(WRTopicReplyModel *)reply withFloor:(WRTopicReplyFloorModel *)floor withResult:(WRTopicManagerResultOperationBlock)resultBlock;

- (void)getUserFavoriteTopicList:(WRUserModel *)user withResult:(WRTopicManagerResultListBlock)resultBlock;

- (void)getUserPostTopicList:(WRUserModel *)user withResult:(WRTopicManagerResultListBlock)resultBlock;

- (void)getUserReplyList:(WRUserModel *)user withResult:(WRTopicManagerResultListBlock)resultBlock;

@end
