//
//  WRGuideStyle.m
//  WeRock
//
//  Created by ZYVincent on 15/4/30.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRGuideStyle.h"

@implementation WRGuideStyle

+ (UIFont *)navigationBarTitleFont
{
    if (GJCFSystemiPhone6Plus) {
        return [UIFont boldSystemFontOfSize:21];
    }else{
        return [UIFont boldSystemFontOfSize:18];
    }
}

+ (UIColor *)navigationBarBackColor
{
    return GJCFQuickHexColor(@"222d29");
}

+ (UIColor *)navigationBarTitleColor
{
    return [UIColor whiteColor];
}

+ (UIColor *)mainBackgroundColor
{
    return GJCFQuickRGBColor(242, 242, 242);
}

+ (UIColor *)mainThemeColor
{
    return GJCFQuickHexColor(@"33a076");
}

+ (UIColor *)mainThemeLightColor
{
    return GJCFQuickHexColor(@"a5bfb4");
}

+ (UIFont *)topicListTitleFont
{
    if (GJCFSystemiPhone6Plus) {
        return [UIFont boldSystemFontOfSize:17];
    }else{
        return [UIFont boldSystemFontOfSize:14];
    }
}

+ (UIColor *)topicListTitleTextColor
{
    return GJCFQuickHexColor(@"202020");
}

+ (UIFont *)topicListSummaryFont
{
    if (GJCFSystemiPhone6Plus) {
        return [UIFont systemFontOfSize:15];
    }else{
        return [UIFont systemFontOfSize:12];
    }
}

+ (UIColor *)topicListSummaryColor
{
    return GJCFQuickHexColor(@"202020");
}

+ (UIFont *)topicListTimeFont
{
    if (GJCFSystemiPhone6Plus) {
        return [UIFont systemFontOfSize:13];
    }else{
        return [UIFont systemFontOfSize:10];
    }
}

+ (UIColor *)topicListTimeColor
{
    return GJCFQuickHexColor(@"808080");
}

+ (UIColor *)topicListNameColor
{
    return GJCFQuickHexColor(@"606060");
}

+ (UIFont *)topicListTagFont
{
    if (GJCFSystemiPhone6Plus) {
        return [UIFont systemFontOfSize:15];
    }else{
        return [UIFont systemFontOfSize:12];
    }
}

+ (UIColor *)topicListTagColor
{
    return [WRGuideStyle mainThemeLightColor];
}


@end
