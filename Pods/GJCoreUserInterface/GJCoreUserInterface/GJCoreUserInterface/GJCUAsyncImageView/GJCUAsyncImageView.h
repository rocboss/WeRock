//
//  GJCFAsyncImageView.h
//  GJCommonFoundation
//
//  Created by ZYVincent on 14-10-30.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJCFUitils.h"
#import "UIView+GJCFViewFrameUitil.h"

@class GJCUAsyncImageView;

typedef void (^GJCUAsyncImageViewDownloadTaskProgressBlock) (GJCUAsyncImageView *imageView,CGFloat progress);

typedef void (^GJCUAsyncImageViewDownloadTaskCompletionBlock) (GJCUAsyncImageView *imageView,BOOL completion);

@interface GJCUAsyncImageView : UIImageView

/**
 *  需要缓存的目标路径，如果没有设置，就启用默认缓存目录路径
 */
@property (nonatomic,strong)NSString *cachePath;

/**
 *  图片地址链接
 */
@property (nonatomic,strong)NSString *url;

/**
 *  图片下载进度
 */
@property (nonatomic,readonly)CGFloat downloadProgress;

/**
 *  任务唯一标示
 */
@property (nonatomic,readonly)NSString *downloadTaskUniqueIdentifier;

/**
 *  转圈
 */
@property (nonatomic,strong)UIActivityIndicatorView *indicatorView;

/**
 *  是否显示转圈
 */
@property (nonatomic,assign)BOOL showDownloadIndicator;

/**
 *  是否在对象被销毁的时候取消下载任务，默认为NO
 */
@property (nonatomic,assign)BOOL isAutoCancel;

/**
 *  从缓存路径读取出的图片
 */
@property (nonatomic,readonly)UIImage *cachedImage;

/**
 *  观察下载任务完成
 *
 *  @param completionBlock 观察者
 */
- (void)configDownloadTaskProgressBlock:(GJCUAsyncImageViewDownloadTaskProgressBlock)progressBlock;

/**
 *  观察任务完成
 *
 *  @param completionBlock 
 */
- (void)configDownloadTaskCompletionBlock:(GJCUAsyncImageViewDownloadTaskCompletionBlock)completionBlock;

/**
 *  调整转圈位置
 */
- (void)adjustIndicatorPosition;

@end
