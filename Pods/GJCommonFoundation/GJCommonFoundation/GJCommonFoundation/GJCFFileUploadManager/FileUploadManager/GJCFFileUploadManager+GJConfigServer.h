//
//  GJCFFileUploadManager+GJConfigServer.h
//  GJCommonFoundation
//
//  Created by ZYVincent on 14-9-15.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import "GJCFFileUploadManager.h"

/* 返回一个绑定了赶集服务器信息得图片上传组件 */
@interface GJCFFileUploadManager (GJConfigServer)

+ (GJCFFileUploadManager *)uploadManagerForGanJiServer;

@end
