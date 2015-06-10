//
//  WRTopicModel.h
//  WeRock
//
//  Created by ZYVincent on 15/4/28.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WRTopicModel : NSObject

@property (nonatomic,strong)NSString *avatar;

@property (nonatomic,strong)NSString *client;

@property (nonatomic,strong)NSString *comments;

@property (nonatomic,strong)NSString *content;

@property (nonatomic,assign)BOOL isTop;

@property (nonatomic,strong)NSString *lastActiveTime;

@property (nonatomic,strong)NSString *postTime;

@property (nonatomic,strong)NSArray *pictures;

@property (nonatomic,strong)NSArray *tagArray;

@property (nonatomic,strong)NSString *tid;

@property (nonatomic,strong)NSString *title;

@property (nonatomic,strong)NSString *userId;

@property (nonatomic,strong)NSString *userName;

@property (nonatomic,assign)BOOL isFavorite;

@property (nonatomic,assign)BOOL isPraise;

@property (nonatomic,assign)BOOL isLock;

- (instancetype)initWithDictionary:(NSDictionary *)contentDict;

- (NSString *)tagArrayString;

@end
