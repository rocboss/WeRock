//
//  WRConditionModel.m
//  WeRock
//
//  Created by ZYVincent on 15/4/28.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRConditionModel.h"

@implementation WRConditionModel

- (instancetype)init
{
    if (self = [super init]) {
        
        self.pageIndex = 1;
        _identifier = [NSString stringWithFormat:@"WRCondition_%@",GJCFStringCurrentTimeStamp];
    }
    return self;
}

@end
