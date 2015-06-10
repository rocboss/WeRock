//
//  WRWhisperModel.m
//  WeRock
//
//  Created by ZYVincent on 15/4/29.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRWhisperModel.h"

@implementation WRWhisperModel

- (instancetype)initWithDictionary:(NSDictionary *)contentDict
{
    if (self = [super init]) {
        
        self.recvUserId = contentDict[@"atuid"];
        self.recvUserAvatar = contentDict[@"avatar"];
        self.content = contentDict[@"content"];
        self.whisperId = contentDict[@"id"];
        self.isRead = contentDict[@"isread"];
        self.postTIme = contentDict[@"posttime"];
        self.fromUserId = contentDict[@"uid"];
        self.recvUserName = contentDict[@"username"];
    }
    return self;
}
@end
