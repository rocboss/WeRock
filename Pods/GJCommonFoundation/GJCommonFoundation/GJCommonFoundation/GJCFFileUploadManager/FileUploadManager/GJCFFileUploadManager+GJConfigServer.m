//
//  GJCFFileUploadManager+GJConfigServer.m
//  GJCommonFoundation
//
//  Created by ZYVincent on 14-9-15.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import "GJCFFileUploadManager+GJConfigServer.h"
#import "GJCFConstantManager.h"

@implementation GJCFFileUploadManager (GJConfigServer)

+ (GJCFFileUploadManager *)uploadManagerForGanJiServer
{
    GJCFConstantManager *constManager = [GJCFConstantManager share];
    
    GJCFFileUploadManager *uploadManager = [[GJCFFileUploadManager alloc]init];
    
    /* 设定主机 */
    [uploadManager setDefaultHostUrl:constManager.gjcfserverDomain];
    
    /* 设定默认Header */
    NSMutableDictionary *defaultHeaders = [NSMutableDictionary dictionary];
    [defaultHeaders setObject:constManager.gjcfagency  forKey:@"agency"];
    [defaultHeaders setObject:constManager.gjcfclientAgent forKey:@"clientAgent"];
    [defaultHeaders setObject:constManager.gjcfcustomId forKey:@"customerId"];
    [defaultHeaders setObject:constManager.gjcfdataVersion forKey:@"GjData-Version"];
    [defaultHeaders setObject:constManager.gjcfversionId forKey:@"versionId"];
    [defaultHeaders setObject:constManager.gjcfmodel forKey:@"model"];
    
    [uploadManager setDefaultRequestHeader:defaultHeaders];
    
    /* 没有默认参数 */
    [uploadManager setDefaultRequestParams:[NSMutableDictionary dictionary]];
    
    return uploadManager;
}

@end
