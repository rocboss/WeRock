//
//  NSDictionary+UrlEncodedString.m
//  TicketSystem
//
//  Created by ZYVincent on 12-2-28.
//  Copyright (c) 2012年 __ZYProSoft__. All rights reserved.

#import "NSDictionary+UrlEncodedString.h"

@implementation NSDictionary(UrlString)

// 转化为UTF8编码
-(NSString *)urlEncode:(id)object {
    NSString *string = (NSString*)object;
    NSString *encodedValue = (__bridge NSString*)CFURLCreateStringByAddingPercentEscapes(nil,
                                                                                         (CFStringRef)string,
                                                                                         nil,
                                                                                         (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                         kCFStringEncodingUTF8);
    return encodedValue;
}

-(NSString*) urlEncodedString {
    NSMutableArray *parts = [NSMutableArray array];
    for (id key in self) {
        @autoreleasepool {
            id value = [self objectForKey: key];
            NSString *part = [NSString stringWithFormat: @"%@=%@",[self urlEncode:key],[self urlEncode:value]];
            [parts addObject: part];
        }
    }
    return [parts componentsJoinedByString: @"&"];//拼装字符串
}


@end
