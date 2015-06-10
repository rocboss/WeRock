//
//  WRHttpResponse.h
//  WeRock
//
//  Created by ZYVincent on 15/4/27.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  响应类型
 */
typedef NS_ENUM(NSUInteger, WRHttpResponseType) {
    /**
     *  成功结果
     */
    WRHttpResponseTypeSuccess,
    /**
     *  进度
     */
    WRHttpResponseTypeProgress,
    /**
     *  失败结果
     */
    WRHttpResponseTypeFaild,
};

@interface WRHttpResponse : NSObject

@property (nonatomic,assign)BOOL status;

@property (nonatomic,assign)NSInteger errorCode;

@property (nonatomic,strong)NSString *errorMsg;

@property (nonatomic,strong)id dataResult;

@property (nonatomic,assign)CGFloat progress;

@property (nonatomic,assign)WRHttpResponseType responseType;

@end
