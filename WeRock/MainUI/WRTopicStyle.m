//
//  WRTopicStyle.m
//  WeRock
//
//  Created by ZYVincent on 15/4/30.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRTopicStyle.h"

@implementation WRTopicStyle

+ (NSAttributedString *)formateTitle:(NSString *)title
{
    GJCFCoreTextAttributedStringStyle *stringStyle = [[GJCFCoreTextAttributedStringStyle alloc]init];
    stringStyle.font = [WRGuideStyle topicListTitleFont];
    stringStyle.foregroundColor = [WRGuideStyle topicListTitleTextColor];
    
    GJCFCoreTextParagraphStyle *paragraphStyle = [[GJCFCoreTextParagraphStyle alloc]init];
    paragraphStyle.minLineSpace = 6.f;
    paragraphStyle.maxLineSpace = 6.f;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:title attributes:[stringStyle attributedDictionary]];
    [string addAttributes:[paragraphStyle paragraphAttributedDictionary] range:GJCFStringRange(title)];
    
    return string;
}

+ (NSAttributedString *)formateSummary:(NSString *)summary
{
    GJCFCoreTextAttributedStringStyle *stringStyle = [[GJCFCoreTextAttributedStringStyle alloc]init];
    stringStyle.font = [WRGuideStyle topicListSummaryFont];
    stringStyle.foregroundColor = [WRGuideStyle topicListSummaryColor];
    
    GJCFCoreTextParagraphStyle *paragraphStyle = [[GJCFCoreTextParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:summary attributes:[stringStyle attributedDictionary]];
    [string addAttributes:[paragraphStyle paragraphAttributedDictionary] range:GJCFStringRange(summary)];
    
    return string;
}

+ (NSAttributedString *)formateContent:(NSString *)content
{
    GJCFCoreTextAttributedStringStyle *stringStyle = [[GJCFCoreTextAttributedStringStyle alloc]init];
    stringStyle.font = [WRGuideStyle topicListSummaryFont];
    stringStyle.foregroundColor = [WRGuideStyle topicListSummaryColor];
    
    GJCFCoreTextParagraphStyle *paragraphStyle = [[GJCFCoreTextParagraphStyle alloc]init];
    paragraphStyle.maxLineSpace = 6.f;
    paragraphStyle.minLineSpace = 6.f;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:content attributes:[stringStyle attributedDictionary]];
    [string addAttributes:[paragraphStyle paragraphAttributedDictionary] range:GJCFStringRange(content)];
    
    return string;
}

+ (NSAttributedString *)formateTime:(NSString *)timeString
{
    GJCFCoreTextAttributedStringStyle *stringStyle = [[GJCFCoreTextAttributedStringStyle alloc]init];
    stringStyle.font = [WRGuideStyle topicListTimeFont];
    stringStyle.foregroundColor = [WRGuideStyle topicListTimeColor];
    
    return [[NSAttributedString alloc]initWithString:timeString attributes:[stringStyle attributedDictionary]];
}

+ (NSAttributedString *)formateReplyCount:(NSString *)count
{
    GJCFCoreTextAttributedStringStyle *stringStyle = [[GJCFCoreTextAttributedStringStyle alloc]init];
    stringStyle.font = [WRGuideStyle topicListTimeFont];
    stringStyle.foregroundColor = [WRGuideStyle topicListTimeColor];
    
    return [[NSAttributedString alloc]initWithString:count attributes:[stringStyle attributedDictionary]];
}

+ (NSAttributedString *)formateNameString:(NSString *)name
{
    GJCFCoreTextAttributedStringStyle *stringStyle = [[GJCFCoreTextAttributedStringStyle alloc]init];
    stringStyle.font = [WRGuideStyle topicListSummaryFont];
    stringStyle.foregroundColor = [WRGuideStyle topicListNameColor];
    
    GJCFCoreTextParagraphStyle *paragraphStyle = [[GJCFCoreTextParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:name attributes:[stringStyle attributedDictionary]];
    [string addAttributes:[paragraphStyle paragraphAttributedDictionary] range:GJCFStringRange(name)];
    
    return string;
}


@end
