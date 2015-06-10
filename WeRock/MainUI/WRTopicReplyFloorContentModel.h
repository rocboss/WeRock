//
//  WRTopicReplyFloorContentModel.h
//  WeRock
//
//  Created by ZYVincent on 15/5/4.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WRTopicReplyFloorContentModel : NSObject

@property (nonatomic,strong)NSAttributedString *contentString;

@property (nonatomic,strong)NSString *userId;

@property (nonatomic,assign)CGFloat contentHeight;


@end
