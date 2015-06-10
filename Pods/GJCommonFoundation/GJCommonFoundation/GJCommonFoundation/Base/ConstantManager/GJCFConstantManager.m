//
//  GJCFConstantManager.m
//  GJCommonFoundation
//
//  Created by liyi on 14-9-10.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import "GJCFConstantManager.h"

@implementation GJCFConstantManager
@synthesize gjcfagency;
@synthesize gjcfclientAgent;
@synthesize gjcfclientTest;
@synthesize gjcfcustomId;
@synthesize gjcfdataVersion;
@synthesize gjcfmodel;
@synthesize gjcfnewServerURL;
@synthesize gjcfserverDomain;
@synthesize gjcfversionId;


+ (instancetype)share
{
    static GJCFConstantManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GJCFConstantManager alloc] init];
    });
    
    return manager;
}


- (NSString *)gjcfmodel
{
    return gjcfmodel ? gjcfmodel : @"Generic/iphone";
}

- (NSString *)gjcfagency
{
    return gjcfagency ? gjcfagency : @"appstore";
}

- (NSString *)gjimdataVersion
{
    return gjcfdataVersion ? gjcfdataVersion : @"2.0";
}

- (NSString *)gjcfnewServerURL
{
    return gjcfnewServerURL ? gjcfnewServerURL : @"http://mobds.ganji.cn/datashare/";
}

- (NSString *)gjcfserverDomain
{
    return gjcfserverDomain ? gjcfserverDomain : @"http://image.ganjistatic1.com";
}

- (void)isRequireParamNoNull
{
    if (!self.gjcfclientTest || !self.gjcfcustomId || !self.gjcfversionId || !self.gjcfclientTest) {
        
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@" gjcfclientTest， gjcfcustomId ，gjcfversionId， gjcfclientTest 必须赋值" userInfo:nil];
    }
}
@end
