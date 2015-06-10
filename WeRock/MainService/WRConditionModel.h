//
//  WRConditionModel.h
//  WeRock
//
//  Created by ZYVincent on 15/4/28.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WRConditionModel : NSObject

@property (nonatomic,readonly)NSString *identifier;

@property (nonatomic,assign)NSInteger pageIndex;

@property (nonatomic,assign)NSInteger pageSize;

@property (nonatomic,strong)NSString *topicSortType;

@property (nonatomic,assign)NSInteger status;

@end
