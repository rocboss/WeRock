//
//  GJCFPOISearch.h
//  GJCommonFoundation
//
//  Created by zhangv on 14-10-20.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "BMapKit.h"

@class GJCFPOISearch;

typedef enum{
    GJMap_SEARCH_NO_ERROR =0,///<检索结果正常返回
    GJMap_SEARCH_AMBIGUOUS_KEYWORD,///<检索词有岐义
    GJMap_SEARCH_AMBIGUOUS_ROURE_ADDR,///<检索地址有岐义
    GJMap_SEARCH_NOT_SUPPORT_BUS,///<该城市不支持公交搜索
    GJMap_SEARCH_NOT_SUPPORT_BUS_2CITY,///<不支持跨城市公交
    GJMap_SEARCH_RESULT_NOT_FOUND,///<没有找到检索结果
    GJMap_SEARCH_ST_EN_TOO_NEAR,///<起终点太近
}GJMapSearchErrorCode;

typedef void (^GJCFPOIsearchBlock) (GJCFPOISearch *poisearch, GJMapSearchErrorCode error);


@interface GJCFPOISearch : NSObject<BMKPoiSearchDelegate>


@property (nonatomic,strong) BMKPoiSearch *POISearch;
@property (nonatomic,strong) NSMutableArray *POIresults;
@property (nonatomic,strong) CLLocation *searchLoaction;
@property (nonatomic,strong) GJCFPOIsearchBlock searchBlock;
// 搜索的半径 单位为米 默认1000
@property (nonatomic)        int  searchradius;


- (void)POIsByLocaton:(CLLocation*)locatio keyWord:(NSString *)keyword  success:(GJCFPOIsearchBlock)success ;

@end
