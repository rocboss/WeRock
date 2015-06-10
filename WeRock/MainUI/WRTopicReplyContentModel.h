//
//  WRTopicReplyContentModel.h
//  WeRock
//
//  Created by ZYVincent on 15/5/3.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WRTopicBaseContentModel.h"

@interface WRTopicReplyContentModel : WRTopicBaseContentModel

@property (nonatomic,strong)NSString *avatar;

@property (nonatomic,strong)NSAttributedString *userName;

@property (nonatomic,strong)NSAttributedString *content;

@property (nonatomic,strong)NSArray *floors;

@property (nonatomic,readonly)NSArray *floorsAttris;

@property (nonatomic,strong)NSArray *pictures;

@property (nonatomic,strong)NSAttributedString *timeString;

@property (nonatomic,strong)NSAttributedString *clientString;

@property (nonatomic,assign)CGFloat contentHeight;

@property (nonatomic,strong)NSString *pid;


@end
