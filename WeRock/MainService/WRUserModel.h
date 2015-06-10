//
//  WRUserModel.h
//  WeRock
//
//  Created by ZYVincent on 15/4/27.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WRUserModel : NSObject

@property (nonatomic,strong)NSString *userId;

@property (nonatomic,strong)NSString *userName;

@property (nonatomic,strong)NSString *password;

@property (nonatomic,strong)NSString *email;

@property (nonatomic,strong)NSString *token;

@property (nonatomic,strong)NSString *groupId;

@property (nonatomic,strong)NSString *groupName;

@property (nonatomic,strong)NSString *qqId;

@property (nonatomic,strong)NSString *money;

@property (nonatomic,strong)NSString *avatar;

@property (nonatomic,strong)NSString *homeThemeBack;

@property (nonatomic,strong)NSString *lastActiveTime;

@property (nonatomic,strong)NSString *registTime;

@property (nonatomic,strong)NSString *scores;

@property (nonatomic,strong)NSString *signature;

@property (nonatomic,strong)NSString *fansCount;

@property (nonatomic,strong)NSString *notificationCount;

@property (nonatomic,strong)NSString *notificationUnReadCount;

@property (nonatomic,strong)NSString *replyCount;

@property (nonatomic,strong)NSString *topicsCount;

@property (nonatomic,strong)NSString *whisperCount;

@property (nonatomic,strong)NSString *whisperUnReadCount;

@property (nonatomic,assign)BOOL isFollow;

@property (nonatomic,strong)NSString *deviceToken;

@property (nonatomic,readonly)BOOL isLock;

@property (nonatomic,strong)NSString *scoreChange;

@property (nonatomic,assign)NSTimeInterval lastSignTime;

- (instancetype)initWithUserInfo:(NSDictionary *)contentDict;

- (instancetype)initWithUserDetailInfo:(NSDictionary *)contentDict;

- (instancetype)initWithMyDetailInfo:(NSDictionary *)contentDict;

- (instancetype)initWithHotSignInfo:(NSDictionary *)contentDict;

@end
