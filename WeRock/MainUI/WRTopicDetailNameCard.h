//
//  WRTopicDetailNameCard.h
//  WeRock
//
//  Created by ZYVincent on 15/5/3.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRTopicContentModel.h"
#import "WRTopicReplyContentModel.h"

@interface WRTopicDetailNameCard : UIView

- (void)setTopicContent:(WRTopicContentModel *)topic;

- (void)setReplyContent:(WRTopicReplyContentModel *)reply;

@end
