//
//  WRTopicReplyFloorCell.h
//  WeRock
//
//  Created by ZYVincent on 15/5/4.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRTopicReplyFloorContentModel.h"

@interface WRTopicReplyFloorCell : UITableViewCell

- (void)setFloor:(WRTopicReplyFloorContentModel *)contentModel;

- (CGFloat)contentHeight;

@end
