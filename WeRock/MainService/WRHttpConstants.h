//
//  WRHttpConstants.h
//  WeRock
//
//  Created by ZYVincent on 15/4/27.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WRServerHost @"http://www.lulingshuo.com/lulingshuo/"

#define WRServerSubPath @"/lulingshuo"

/**
 *  所有接口管理
 */
typedef NS_ENUM(NSUInteger, WRHttpRequestType) {
    /**
     *  未定义请求
     */
    WRHttpRequestTypeUndeifne,
    /**
     *  用户登录
     */
    WRHttpRequestTypeUserLogin,
    /**
     *  用户注册
     */
    WRHttpRequestTypeUserRegist,
    /**
     *  用户详情
     */
    WRHttpRequestTypeUserDetail,
    /**
     *  用户发表的主题
     */
    WRHttpRequestTypeUserTopics,
    /**
     *  用户的回复列表
     */
    WRHttpRequestTypeUserReply,
    /**
     *  用户的私信
     */
    WRHttpRequestTypeUserWhisper,
    /**
     *  用户的偶像列表
     */
    WRHttpRequestTypeUserFollow,
    /**
     *  用户的粉丝列表
     */
    WRHttpRequestTypeUserFans,
    /**
     *  用户的提醒列表
     */
    WRHttpRequestTypeUserNotification,
    /**
     *  用户申请解锁帖子或举报锁住某个帖子
     */
    WRHttpRequestTypeUserApplyLockTopic,
    /**
     *  用户申请解除禁言或举报禁言某个用户
     */
    WRHttpRequestTypeUserApplyLockAction,
    /**
     *  用户注册推送设备
     */
    WRHttpRequestTypeUserRegistDevice,
    /**
     *  关注某人
     */
    WRHttpRequestTypeDoFollow,
    /**
     *  发贴
     */
    WRHttpRequestTypeDoPostTopic,
    /**
     *  回复帖子
     */
    WRHttpRequestTypeDoPostReply,
    /**
     *  楼中楼回复
     */
    WRHttpRequestTypeDoPostFloor,
    /**
     *  删除帖子
     */
    WRHttpRequestTypeDoDeleteTopic,
    /**
     *  收藏帖子
     */
    WRHttpRequestTypeDoFavorTopic,
    /**
     *  点赞帖子
     */
    WRHttpRequestTypeDoPraiseTopic,
    /**
     *  发送私信
     */
    WRHttpRequestTypeDoDeliverWhisper,
    /**
     *  设置签名
     */
    WRHttpRequestTypeDoSetSign,
    /**
     *  签到
     */
    WRHttpRequestTypeDoSign,
    /**
     *  首页帖子列表
     */
    WRHttpRequestTypeHomeIndex,
    /**
     *  帖子详情
     */
    WRHttpRequestTypeHomeRead,
    /**
     *  帖子搜索
     */
    WRHttpRequestTypeHomeSearch,
    /**
     *  按标签查看帖子
     */
    WRHttpRequestTypeHomeTag,
    /**
     *  获取帖子回复列表
     */
    WRHttpRequestTypeHomeGetReplyList,
    /**
     *  获取楼中楼回复列表
     */
    WRHttpRequestTypeHomeGetReplyFloorList,
    /**
     *  获取热门标签
     */
    WRHttpRequestTypeHomeGetHotTags,
    /**
     *  获取热门帖子
     */
    WRHttpRequestTypeHomeGetHotTopics,
    /**
     *  获取热门签到用户
     */
    WRHttpRequestTypeHomeGetTodayTopSign,
    /**
     *  锁帖子
     */
    WRHttpRequestTypeManagerLockTopic,
    /**
     *  置顶帖子
     */
    WRHttpRequestTypeManagerTopTopic,
    /**
     *  管理用户行为申请
     */
    WRHttpRequestTypeAdminUserApplyList,
    /**
     *  管理帖子行为申请
     */
    WRHttpRequestTypeAdminTopicApplyList,
    /**
     *  搜索用户
     */
    WRHttpRequestTypeAdminSearchUser,
    /**
     *  禁言用户
     */
    WRHttpRequestTypeAdminLockUser,
    /**
     *  上传头像
     */
    WRHttpRequestTypeUploadAvatar,
    /**
     *  上传主页背景
     */
    WRHttpRequestTypeUploadHomeBackTheme,
    /**
     *  普通图片上传
     */
    WRHttpRequestTypeUploadPicture,
};

@interface WRHttpConstants : NSObject

+ (NSString *)requestTypeToInterface:(WRHttpRequestType)requestType;

@end
