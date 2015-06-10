//
//  GJCFFileUploadManager+IMServer.m
//  GJCommonFoundation
//
//  Created by ZYVincent on 14-9-18.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import "GJCFFileUploadManager+IMServer.h"
#import "GJCFConstantManager.h"

@implementation GJCFFileUploadManager (IMServer)

+ (BOOL)checkDefaultHeadersValue
{
    GJCFConstantManager *constManager = [GJCFConstantManager share];

    if (!constManager.gjcfagency || !constManager.gjcfclientAgent || !constManager.gjcfcustomId || !constManager.gjcfdataVersion || !constManager.gjcfversionId || !constManager.gjcfmodel || !constManager.gjcfserverDomain) {
        
        return NO;
    }
    return YES;
}

+ (GJCFFileUploadManager *)imServerUploadManager
{
    GJCFConstantManager *constManager = [GJCFConstantManager share];
    
    
    GJCFFileUploadManager *uploadManager = [[GJCFFileUploadManager alloc]init];
    
    /* 必须要有合法的requeshtHeader */
    if (![GJCFFileUploadManager checkDefaultHeadersValue]) {
        
        NSLog(@"GJCFUploadManager+IMServer 没有找到合法的默认requestHeader");
        
        return uploadManager;
    }
    
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
    
    [uploadManager setDefaultUploadPath:@"UploadImages"];
    
    /* 没有默认参数 */
    [uploadManager setDefaultRequestParams:[NSMutableDictionary dictionary]];
    
    return uploadManager;

}

@end
