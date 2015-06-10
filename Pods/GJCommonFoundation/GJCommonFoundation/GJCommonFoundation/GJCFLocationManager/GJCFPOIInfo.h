//
//  GJCFPOIInfo.h
//  GJCommonFoundation
//
//  Created by zhangv on 14-10-20.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "BMapKit.h"

@interface GJCFPOIInfo : NSObject

///POI名称
@property (nonatomic, copy) NSString* name;
///POIuid
@property (nonatomic, copy) NSString* uid;
///POI地址
@property (nonatomic, copy) NSString* address;
///POI所在城市
@property (nonatomic, copy) NSString* city;
///POI电话号码
@property (nonatomic, copy) NSString* phone;
///POI邮编
@property (nonatomic, copy) NSString* postcode;
///POI类型，0:普通点 1:公交站 2:公交线路 3:地铁站 4:地铁线路
@property (nonatomic) int epoitype;
///POI坐标
@property (nonatomic) CLLocationCoordinate2D pt;

-(id)initWithBMKPoiInfo:(BMKPoiInfo*) bmkpoiInfo;
-(id)initWithDictionary:(NSDictionary*)dict;
@end
