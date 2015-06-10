//
//  WRTopicContentModel.h
//  WeRock
//
//  Created by ZYVincent on 15/4/30.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WRTopicBaseContentModel.h"

@interface WRTopicContentModel : WRTopicBaseContentModel

@property (nonatomic,strong)NSAttributedString *titleString;

@property (nonatomic,strong)NSAttributedString *nameString;

@property (nonatomic,strong)NSAttributedString *summaryString;

@property (nonatomic,strong)NSAttributedString *timeString;

@property (nonatomic,strong)NSAttributedString *replyCountString;

@property (nonatomic,strong)NSAttributedString *clientString;

@property (nonatomic,strong)NSString *headUrl;

@property (nonatomic,strong)NSArray *picArray;

@property (nonatomic,assign)CGFloat contentHeight;

@property (nonatomic,strong)NSString *tid;

@property (nonatomic,strong)NSString *groupName;

@end
