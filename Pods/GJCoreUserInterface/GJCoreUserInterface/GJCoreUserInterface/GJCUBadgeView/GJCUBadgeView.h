//
//  GJCUBadgeView.h
//  GJCoreUserInterface
//
//  Created by ZYVincent on 14-10-31.
//  Copyright (c) 2014年 ganji. All rights reserved.
//



/**
 * 感谢代码原作者: https://github.com/lakesoft
 * thanks author: https://github.com/lakesoft
 * github地址: https://github.com/lakesoft/LKBadgeView
 * 作者没有将这个库提交到GitHub cocoaPods的spec库中，不能通过pod 'LKBadgeView",'1.2.0'方式引用
 * 所以将这个库搬移到我们的库中，为了防止别的项目也引入了LKBadgeView
 * 我们进行了重新命名
 */

#import <UIKit/UIKit.h>

// Enums
typedef enum {
    GJCUBadgeViewHorizontalAlignmentLeft = 0,
    GJCUBadgeViewHorizontalAlignmentCenter,
    GJCUBadgeViewHorizontalAlignmentRight
    
} GJCUBadgeViewHorizontalAlignment;

typedef enum {
    GJCUBadgeViewWidthModeStandard = 0,     // 30x20
    GJCUBadgeViewWidthModeSmall            // 22x20
} GJCUBadgeViewWidthMode;

typedef enum {
    GJCUBadgeViewHeightModeStandard = 0,    // 20
    GJCUBadgeViewHeightModeLarge             // 30
} GJCUBadgeViewHeightMode;


// Constants
#define GJCU_BADGE_VIEW_STANDARD_HEIGHT       20.0
#define GJCU_BADGE_VIEW_LARGE_HEIGHT          30.0
#define GJCU_BADGE_VIEw_STANDARD_WIDTH        30.0
#define GJCU_BADGE_VIEw_MINIMUM_WIDTH         22.0
#define GJCU_BADGE_VIEW_FONT_SIZE             16.0


@interface GJCUBadgeView : UIView

@property (nonatomic, copy) NSString* text;
@property (nonatomic, strong) UIColor* textColor;
@property (nonatomic, strong) UIFont* font;
@property (nonatomic, strong) UIColor* badgeColor;
@property (nonatomic, strong) UIColor* outlineColor;
@property (nonatomic, assign) CGFloat outlineWidth;
@property (nonatomic, assign) BOOL outline;
@property (nonatomic, assign) GJCUBadgeViewHorizontalAlignment horizontalAlignment;
@property (nonatomic, assign) GJCUBadgeViewWidthMode widthMode;
@property (nonatomic, assign) GJCUBadgeViewHeightMode heightMode;
@property (nonatomic, assign) BOOL shadow;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, assign) CGFloat shadowBlur;
@property (nonatomic, strong) UIColor* shadowColor;
@property (nonatomic, assign) BOOL shadowOfOutline;
@property (nonatomic, assign) BOOL shadowOfText;
@property (nonatomic, assign) CGSize textOffset;

+ (CGFloat)badgeHeight; // @depricated
- (CGFloat)badgeHeight;

@end
