//
//  WRHomeBaseCell.h
//  WeRock
//
//  Created by ZYVincent on 15/5/11.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRHomeContentBaseModel.h"

@interface WRHomeBaseCell : UITableViewCell

- (void)setContentModel:(WRHomeContentBaseModel *)contentModel;

- (CGFloat)contentHeight;

@end
