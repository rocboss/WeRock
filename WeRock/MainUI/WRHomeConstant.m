//
//  WRHomeConstant.m
//  WeRock
//
//  Created by ZYVincent on 15/5/11.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRHomeConstant.h"

@implementation WRHomeConstant

+(NSDictionary *)classContentTypeDict
{
    return @{
             @"WRHomeHeaderCell":@"WRHomeHeaderCellIdentifier",
             @"WRHomeMenuItemCell":@"WRHomeMenuItemCellIdentifier",
             @"WRHomePersonalSignCell":@"WRHomePersonalSignCellIdentifier",
             @"WRHomeFansAndForllowsCell":@"WRHomeFansAndForllowsCellIdentifier",
             };
}

+ (NSDictionary *)identifierContentTypeDict
{
    return @{
             @(WRHomeContentTypeHeader):@"WRHomeHeaderCell",
             @(WRHomeContentTypeMenuItem):@"WRHomeMenuItemCell",
             @(WRHomeContentTypePersonSign):@"WRHomePersonalSignCell",
             @(WRHomeContentTypeFansAndForllows):@"WRHomeFansAndForllowsCell",
             };
}

+ (Class)classForContentType:(WRHomeContentType)contentType
{
    return NSClassFromString([[WRHomeConstant identifierContentTypeDict] objectForKey:@(contentType)]);
}

+ (NSString *)identifierForContentType:(WRHomeContentType)contentType
{
    return [[WRHomeConstant classContentTypeDict]objectForKey:[[WRHomeConstant classContentTypeDict]objectForKey:@(contentType)]];
}

@end
