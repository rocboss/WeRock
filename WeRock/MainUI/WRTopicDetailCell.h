//
//  WRTopicDetailCell.h
//  WeRock
//
//  Created by ZYVincent on 15/5/3.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRTopicContentModel.h"

@class WRTopicDetailCell;
@protocol WRTopicDetailCellDelegate <NSObject>

- (void)topicDetailCellNeedUpdateContentHeight:(WRTopicDetailCell *)cell withNewContentHeight:(CGFloat)height;

@end

@interface WRTopicDetailCell : UITableViewCell

@property (nonatomic,weak)id<WRTopicDetailCellDelegate> delegate;

- (void)setTopicContent:(WRTopicContentModel *)topic;

- (CGFloat)contentHeight;

@end
