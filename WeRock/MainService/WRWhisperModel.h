//
//  WRWhisperModel.h
//  WeRock
//
//  Created by ZYVincent on 15/4/29.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WRWhisperModel : NSObject

@property (nonatomic,strong)NSString *whisperId;

@property (nonatomic,strong)NSString *recvUserId;

@property (nonatomic,strong)NSString *fromUserId;

@property (nonatomic,strong)NSString *recvUserAvatar;

@property (nonatomic,strong)NSString *content;

@property (nonatomic,assign)BOOL isRead;

@property (nonatomic,strong)NSString *postTIme;

@property (nonatomic,strong)NSString *recvUserName;

- (instancetype)initWithDictionary:(NSDictionary *)contentDict;

@end
