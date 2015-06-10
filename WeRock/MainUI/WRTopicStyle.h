//
//  WRTopicStyle.h
//  WeRock
//
//  Created by ZYVincent on 15/4/30.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WRTopicStyle : NSObject

+ (NSAttributedString *)formateTitle:(NSString *)title;

+ (NSAttributedString *)formateContent:(NSString *)content;

+ (NSAttributedString *)formateSummary:(NSString *)summary;

+ (NSAttributedString *)formateTime:(NSString *)timeString;

+ (NSAttributedString *)formateReplyCount:(NSString *)count;

+ (NSAttributedString *)formateNameString:(NSString *)name;

@end
