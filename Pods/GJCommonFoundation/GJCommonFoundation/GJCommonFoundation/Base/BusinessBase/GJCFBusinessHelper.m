//
//  GJCFBusinessHelper.m
//  GJCommonFoundation
//
//  Created by liyi on 14-9-11.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import "GJCFBusinessHelper.h"
#import "GJCFConstantManager.h"
@implementation GJCFBusinessHelper


+ (NSMutableDictionary *)getDefaultHeader
{
    NSMutableDictionary *header = [NSMutableDictionary dictionary];
    
    [header setObject:[GJCFConstantManager share].gjcfcustomId forKey:@"customerId"];
    [header setObject:[GJCFConstantManager share].gjcfclientAgent forKey:@"clientAgent"];
    [header setObject:[GJCFConstantManager share].gjcfversionId forKey:@"versionId"];
    [header setObject:[GJCFConstantManager share].gjcfmodel forKey:@"model"];
    [header setObject:[GJCFConstantManager share].gjcfagency forKey:@"agency"];
    
    return header;
}

@end
