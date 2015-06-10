//
//  WRTopicModel.m
//  WeRock
//
//  Created by ZYVincent on 15/4/28.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRTopicModel.h"
#import "WRHttpUitil.h"
#import "WRHttpConstants.h"

@implementation WRTopicModel

- (instancetype)initWithDictionary:(NSDictionary *)contentDict
{
    if (self = [super init]) {
       
        self.title = [contentDict objectForKey:@"title"];
        self.tid  = [contentDict objectForKey:@"tid"];
        self.content = [contentDict objectForKey:@"content"];
        self.comments = [contentDict objectForKey:@"comments"];
        self.avatar = [WRHttpUitil serverPicUrl:[contentDict objectForKey:@"avatar"]];
        self.client = GJCFStringIsNull([contentDict objectForKey:@"client"])? @"Web":[contentDict objectForKey:@"client"];
        self.isTop = [[contentDict objectForKey:@"istop"]boolValue];
        self.lastActiveTime = [contentDict objectForKey:@"lasttime"];
        
        NSMutableArray *combinePicUrls = [NSMutableArray array];
        for (NSString *url in [contentDict objectForKey:@"pictures"]) {
            
            NSString *combineUrl = url;
            if ([url hasPrefix:WRServerSubPath]) {
                combineUrl  = [NSString stringWithFormat:@"http://www.lulingshuo.com%@",url];
            }else{
                combineUrl =  [NSString stringWithFormat:@"%@%@",WRServerHost,url];
            }
            [combinePicUrls addObject:combineUrl];
        }
        self.pictures = combinePicUrls;
        NSLog(@"pictures :%@",self.pictures);
        
        self.postTime = [contentDict objectForKey:@"posttime"];
        self.tagArray = [contentDict objectForKey:@"tagArray"];
        self.userId = [contentDict objectForKey:@"uid"];
        self.userName = [contentDict objectForKey:@"username"];
    }
    return self;
}

- (NSString *)tagArrayString
{
    if (self.tagArray.count == 0) {
        return @"";
    }
    
    NSMutableString *tagString = [NSMutableString string];
    for (NSInteger index = 0; index < self.tagArray.count ;index++) {
        
        if (index != self.tagArray.count-1) {
         
            [tagString appendFormat:@"%@,",[self.tagArray objectAtIndex:index]];
        }else{
            [tagString appendString:[self.tagArray objectAtIndex:index]];
        }
    }
    
    return tagString;
}

@end
