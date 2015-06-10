//
//  GJCFConstantManager.h
//  GJCommonFoundation
//  宿主传入参数管理器
//  Created by liyi on 14-9-10.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJCFConstantManager : NSObject

/**
 *  分辨率
 */
@property (nonatomic,strong) NSString *gjcfclientAgent;
/**
 *  项目id 705 710之类
 */
@property (nonatomic,strong) NSString *gjcfcustomId;
/**
 *  Generic/iphone
 */
@property (nonatomic,strong) NSString *gjcfmodel;
/**
 *  渠道，比如appstore
 */
@property (nonatomic,strong) NSString *gjcfagency;
/**
 *  宿主项目版本
 */
@property (nonatomic,strong) NSString *gjcfversionId;
/**
 *  客户端测试
 */
@property (nonatomic,strong) NSString *gjcfclientTest;

/**
 *  新服务器地址
 */
@property (nonatomic,strong) NSString *gjcfnewServerURL;
/**
 *  服务器地址
 */
@property (nonatomic,strong) NSString *gjcfserverDomain;
/**
 *  数据版本
 */
@property (nonatomic,strong) NSString *gjcfdataVersion;

/**
 *  单例
 *
 *  @return 当前类对象
 */
+ (instancetype)share;

/**
 *  判断是否必要的值都赋值了
 */
- (void)isRequireParamNoNull;

@end
