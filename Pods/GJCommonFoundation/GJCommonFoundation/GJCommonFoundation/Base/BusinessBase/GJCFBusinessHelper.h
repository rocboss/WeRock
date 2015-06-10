//
//  GJCFBusinessHelper.h
//  GJCommonFoundation
//
//  Created by liyi on 14-9-11.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJCFBusinessHelper : NSObject

/**
 *  获取业务需要用的默认头字典
 *
 *  @return Http头字典
 */
+ (NSMutableDictionary *)getDefaultHeader;

@end
