//
//  WRUserModel.m
//  WeRock
//
//  Created by ZYVincent on 15/4/27.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRUserModel.h"

@implementation WRUserModel

- (instancetype)init{
    
    if (self = [super init]) {
        
        _isLock = NO;
    }
    return self;
}

- (instancetype)initWithUserInfo:(NSDictionary *)contentDict
{
    if (self = [super init]) {
        
        self.userId = contentDict[@"uid"];
        self.email = contentDict[@"email"];
        self.avatar = contentDict[@"avatar"];
        self.groupId = contentDict[@"groupid"];
        self.groupName = contentDict[@"groupname"];
        self.lastActiveTime = contentDict[@"lasttime"];
        self.money = contentDict[@"money"];
        self.qqId = contentDict[@"qqid"];
        self.registTime = contentDict[@"regtime"];
        self.scores = contentDict[@"scores"];
        self.signature = contentDict[@"signature"];
        self.token = contentDict[@"token"];
        self.userName = contentDict[@"username"];
        _isLock = [contentDict[@"groupid"]intValue] == 0;
    }
    return self;
}

- (instancetype)initWithUserDetailInfo:(NSDictionary *)contentDict
{
    if (self = [super init]) {
        
        NSDictionary *userInfo = [contentDict objectForKey:@"userInfo"];
        self.userId = userInfo[@"uid"];
        self.email = userInfo[@"email"];
        self.avatar = userInfo[@"avatar"];
        self.groupId = userInfo[@"groupid"];
        self.groupName = userInfo[@"groupname"];
        self.lastActiveTime = userInfo[@"lasttime"];
        self.money = userInfo[@"money"];
        self.qqId = userInfo[@"qqid"];
        self.registTime = userInfo[@"regtime"];
        self.scores = userInfo[@"scores"];
        self.signature = userInfo[@"signature"];
        self.token = userInfo[@"token"];
        self.userName = userInfo[@"username"];
        _isLock = [userInfo[@"groupid"]intValue] == 0;

        self.fansCount = contentDict[@"fansCount"];
        self.isFollow = contentDict[@"isFollow"];
        self.replyCount = contentDict[@"replyCount"];
        self.topicsCount = contentDict[@"topicsCount"];

    }
    return self;
}

- (instancetype)initWithMyDetailInfo:(NSDictionary *)contentDict
{
    if (self = [super init]) {
        
        NSDictionary *userInfo = [contentDict objectForKey:@"userInfo"];
        self.userId = userInfo[@"uid"];
        self.email = userInfo[@"email"];
        self.avatar = userInfo[@"avatar"];
        self.groupId = userInfo[@"groupid"];
        self.groupName = userInfo[@"groupname"];
        self.lastActiveTime = userInfo[@"lasttime"];
        self.money = userInfo[@"money"];
        self.qqId = userInfo[@"qqid"];
        self.registTime = userInfo[@"regtime"];
        self.scores = userInfo[@"scores"];
        self.signature = userInfo[@"signature"];
        self.token = userInfo[@"token"];
        self.userName = userInfo[@"username"];
        _isLock = [userInfo[@"groupid"]intValue] == 0;

        self.notificationCount = contentDict[@"notificationCount"];
        self.notificationUnReadCount = contentDict[@"notificationUnreadCount"];
        self.whisperCount = contentDict[@"whisperCount"];
        self.whisperUnReadCount = contentDict[@"whisperUnreadCount"];

        self.fansCount = contentDict[@"fansCount"];
        self.replyCount = contentDict[@"replyCount"];
        self.topicsCount = contentDict[@"topicsCount"];
        
    }
    return self;
}

- (instancetype)initWithHotSignInfo:(NSDictionary *)contentDict
{
    if (self = [super init]) {
        
        self.avatar = [contentDict objectForKey:@"avatar"];
        self.userName = [contentDict objectForKey:@""];
        self.userId = [contentDict objectForKey:@"uid"];
        self.scoreChange = [contentDict objectForKey:@"changed"];
        self.lastSignTime = [[contentDict objectForKey:@"time"]doubleValue];

    }
    return self;
}

@end
