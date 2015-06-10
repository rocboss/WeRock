//
//  GJCFHttpHelperBase.h
//  GJCommonFoundation
//
//  Created by liyi on 14-9-10.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#ifndef GJCommonFoundation_GJCFHttpHelperBase_h
#define GJCommonFoundation_GJCFHttpHelperBase_h

typedef enum GJCFHttpErrorCode
{
    /**
     *  请求未知错误
     */
    GJCFHttpUnKnowError,
    /**
     *  请求非200错误
     */
    GJCFHttpNo200Error,
    /**
     *  请求参数错误
     */
    GJCFHttpParamError
} GJCFHttpErrorCode;

#endif
