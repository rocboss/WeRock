//
//  WRTopicReplyContentModel.m
//  WeRock
//
//  Created by ZYVincent on 15/5/3.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRTopicReplyContentModel.h"

@implementation WRTopicReplyContentModel

- (instancetype)init
{
    if (self = [super init]) {
        
        self.contentType = WRTopicContentTypeReply;
        
    }
    return self;
}

- (void)setFloors:(NSArray *)floors
{
    _floors = floors;
    
    NSMutableArray *floorUsers = [NSMutableArray array];
    
    for (NSDictionary *floor in floors) {
        
        [floorUsers addObject:[self floorAttrisWithFloor:floor]];
        
    }
    
    _floorsAttris = floorUsers;
}

- (NSAttributedString *)floorAttrisWithFloor:(NSDictionary *)floorDict
{
    GJCFCoreTextAttributedStringStyle *stringStyle = [[GJCFCoreTextAttributedStringStyle alloc]init];
    stringStyle.font = [WRGuideStyle topicListSummaryFont];
    stringStyle.foregroundColor = [WRGuideStyle topicListSummaryColor];
    
    GJCFCoreTextParagraphStyle *paragraphStyle = [[GJCFCoreTextParagraphStyle alloc]init];
    paragraphStyle.maxLineSpace = 5.f;
    paragraphStyle.minLineSpace = 5.f;
    
    NSMutableString *floorString = [NSMutableString string];
    [floorString appendFormat:@"%@ : %@     %@",floorDict[@"floorUser"],floorDict[@"floorContent"],floorDict[@"floorTime"]];
    
    NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc]initWithString:floorString attributes:[stringStyle attributedDictionary]];
    
    GJCFCoreTextKeywordAttributedStringStyle *keywordStyle = [[GJCFCoreTextKeywordAttributedStringStyle alloc]init];
    keywordStyle.keyword = floorDict[@"floorUser"];
    keywordStyle.keywordColor = [UIColor blueColor];
    keywordStyle.font = [UIFont systemFontOfSize:14];
    [resultString setKeywordEffectByStyle:keywordStyle];
    
    GJCFCoreTextKeywordAttributedStringStyle *timeKeyStyle = [[GJCFCoreTextKeywordAttributedStringStyle alloc]init];
    timeKeyStyle.keyword = floorDict[@"floorTime"];
    timeKeyStyle.keywordColor = [WRGuideStyle topicListTimeColor];
    timeKeyStyle.font = [UIFont systemFontOfSize:12];
    [resultString setKeywordEffectByStyle:timeKeyStyle];
    
    [resultString addAttributes:[paragraphStyle paragraphAttributedDictionary] range:GJCFStringRange(floorString)];
    
    return resultString;
}

@end
