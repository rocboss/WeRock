//
//  WRHomeConstant.h
//  WeRock
//
//  Created by ZYVincent on 15/5/11.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  cell类型
 */
typedef NS_ENUM(NSUInteger, WRHomeContentType) {
    /**
     *  顶部
     */
    WRHomeContentTypeHeader,
    /**
     *  粉丝和偶像
     */
    WRHomeContentTypeFansAndForllows,
    /**
     *  个人签名
     */
    WRHomeContentTypePersonSign,
    /**
     *  普通选项
     */
    WRHomeContentTypeMenuItem,
};

@interface WRHomeConstant : NSObject

+ (Class)classForContentType:(WRHomeContentType)contentType;

+ (NSString *)identifierForContentType:(WRHomeContentType)contentType;

@end
