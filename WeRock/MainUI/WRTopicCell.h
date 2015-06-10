//
//  WRTopicCell.h
//  WeRock
//
//  Created by ZYVincent on 15/4/30.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRTopicContentModel.h"

@interface WRTopicCell : UITableViewCell

- (void)setcontentModel:(WRTopicContentModel *)topic;

- (CGFloat)contentHeight;

- (void)downloadImage:(NSArray *)imageUrls;

@end
