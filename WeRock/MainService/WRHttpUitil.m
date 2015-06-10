//
//  WRHttpUitil.m
//  WeRock
//
//  Created by ZYVincent on 15/4/29.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRHttpUitil.h"
#import "WRHttpConstants.h"

@implementation WRHttpUitil

+ (NSString *)serverPicUrl:(NSString *)subPath
{
    return [NSString stringWithFormat:@"http://www.lulingshuo.com/%@",subPath];
}

@end
