//
//  GJCFPOISearch.m
//  GJCommonFoundation
//
//  Created by zhangv on 14-10-20.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import "GJCFPOISearch.h"
#import "GJCFPOIInfo.h"


@implementation GJCFPOISearch

-(id)init{
    self = [super init];
    if (self) {
        _POISearch = [[BMKPoiSearch alloc] init];
        _POIresults = [[NSMutableArray alloc] init];
        _searchradius = 1000;
    }
    return self;
}

- (void)POIsByLocaton:(CLLocation*)locatio keyWord:(NSString *)keyword  success:(GJCFPOIsearchBlock)success
{
    
    
    _POISearch.delegate = self;
    self.searchBlock = success;
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc] init];
    option.location = locatio.coordinate;
    option.radius = _searchradius;
    option.pageIndex = 0;
    option.pageCapacity =20;
    option.keyword = keyword;
    
    BOOL issend = [_POISearch poiSearchNearBy:option];
    if (!issend) {
        NSLog(@"POI搜索 发送失败");
    }
    
  
}

-(void)dealloc{
    _POISearch = nil;
    _POIresults = nil;
}



/**
 *返回POI搜索结果
 *@param searcher 搜索对象
 *@param poiResult 搜索结果列表
 *@param errorCode 错误号，@see BMKSearchErrorCode
 */
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode{
    if (errorCode == BMK_SEARCH_NO_ERROR) {
		for (int i = 0; i < poiResult.poiInfoList.count; i++) {
            BMKPoiInfo* bmkpoi = [poiResult.poiInfoList objectAtIndex:i];
            GJCFPOIInfo *gjpoiInfo = [[GJCFPOIInfo alloc] initWithBMKPoiInfo:bmkpoi];
            [_POIresults addObject:gjpoiInfo];

        }
    }
    
    dispatch_async( dispatch_get_main_queue(), ^{
        int code = errorCode;
        GJMapSearchErrorCode error = code;
        _searchBlock(self, error);
    });

    
}


@end
