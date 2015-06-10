//
//  WRTopicReplyCell.h
//  WeRock
//
//  Created by ZYVincent on 15/5/3.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRTopicReplyContentModel.h"

@class WRTopicReplyCell;
@protocol WRTopicReplyCellDelegate <NSObject>

- (void)topicReplyCell:(WRTopicReplyCell *)replyCell needUpdateContentHeight:(CGFloat )contentHeight;

- (void)topicReplyCellNeedCheckMoreFloor:(WRTopicReplyCell *)replyCell;

@end

@interface WRTopicReplyCell : UITableViewCell

@property (nonatomic,weak)id<WRTopicReplyCellDelegate> delegate;

- (void)setReply:(WRTopicReplyContentModel *)contentModel;

- (CGFloat)contentHeight;

@end
