//
//  WRTopicBaseContentModel.h
//  WeRock
//
//  Created by ZYVincent on 15/5/3.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WRTopicContentType) {
    WRTopicContentTypeTopic,
    WRTopicContentTypeReply,
};

@interface WRTopicBaseContentModel : NSObject
@property (nonatomic,assign)WRTopicContentType contentType;

@end
