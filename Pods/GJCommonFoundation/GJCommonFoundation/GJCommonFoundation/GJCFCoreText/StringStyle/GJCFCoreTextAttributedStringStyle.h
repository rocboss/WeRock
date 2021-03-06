//
//  GJCFAttributedStringStyle.h
//  GJCommonFoundation
//
//  Created by ZYVincent on 14-9-22.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface GJCFCoreTextAttributedStringStyle : NSObject

//字形
@property (nonatomic,assign)long characterShape;

//字体
@property (nonatomic,strong)UIFont    *font;

//两个字之间的距离
@property (nonatomic,assign)long   characterGap;

//是否连字属性
@property (nonatomic,assign)BOOL      isLigature;

//前景色
@property (nonatomic,strong)UIColor   *foregroundColor;

//是否从上下文取前景色
@property (nonatomic,assign)BOOL      isForegoundColorContext;

//笔画宽度
@property (nonatomic,assign)CGFloat   strokeWidth;

//笔画颜色，默认前景色
@property (nonatomic,strong)UIColor   *strokeColor;

//设置字体的上下标属性 必须是CFNumberRef对象 默认为0,可为-1为下标,1为上标，需要字体支持才行。如排列组合的样式Cn1
@property (nonatomic,assign)NSUInteger superScript;

//字体下划线颜色
@property (nonatomic,strong)UIColor   *underLineColor;

//字体下划线样式属性 必须是CFNumberRef对象,默为kCTUnderlineStyleNone 可以通过CTUnderlineStypleModifiers 进行修改下划线风格
@property (nonatomic,assign)CTUnderlineStyle    underLineStyle;

//文字的字形方向属性 必须是CFBooleanRef 默认为false，false表示水平方向，true表示竖直方向
@property (nonatomic,assign)BOOL isVertical;

//返回对象的所有属性字典
- (NSDictionary *)attributedDictionary;

/* =============== 各单独属性字典,需要设置对应的属性值，否则返回空的状态字典 ====================== */

//字体
- (NSDictionary *)fontAttributedDictionary;

//字形
- (NSDictionary *)characterGapAttributedDictionary;

//两个字之间的距离
- (NSDictionary *)charaterShapeAttributedDictionary;

//是否连字属性
- (NSDictionary *)ligatureAttributedDictionary;

//前景色
- (NSDictionary *)foregroundColorAttributedDictionary;

//是否从上下文取前景色
- (NSDictionary *)foregroundColorFromContextAttributedDictionary;

//笔画宽度
- (NSDictionary *)strokeWidthAttributedDictionary;

//笔画颜色，默认前景色
- (NSDictionary *)strokeColorAttributedDictionary;

//设置字体的上下标属性 必须是CFNumberRef对象 默认为0,可为-1为下标,1为上标，需要字体支持才行。如排列组合的样式Cn1
- (NSDictionary *)superScriptAttributedDictionary;

//字体下划线颜色
- (NSDictionary *)underLineColorAttributedDictionary;

//字体下划线样式属性 必须是CFNumberRef对象,默为kCTUnderlineStyleNone 可以通过CTUnderlineStypleModifiers 进行修改下划线风格
- (NSDictionary *)underLineStyleAttributedDictionary;

//文字的字形方向属性 必须是CFBooleanRef 默认为false，false表示水平方向，true表示竖直方向
- (NSDictionary *)isVerticalAttributedDictionary;

@end
