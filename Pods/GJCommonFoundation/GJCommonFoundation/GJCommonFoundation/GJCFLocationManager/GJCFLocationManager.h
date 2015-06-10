//
//  GJCFLocationManager.h
//  GJCommonFoundation
//
//  Created by zhangv on 14-10-20.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "BMapKit.h"
#import "GJCFPOISearch.h"
#import "GJCFPOIInfo.h"

#define GJCF_NOTIFICATION_CHANGE_LOCALTION @"GJCF_NOTIFICATION_CHANGE_LOCALTION"

@interface GJCFLocationManager : NSObject<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeneralDelegate,CLLocationManagerDelegate>
{
    
    BMKLocationService* _locService;
    CLLocationManager *locationManager;
}

+ (GJCFLocationManager*) sharedManager ;
- (void) initBaiduAPPKey:(NSString*)key;
- (void) initSystemLoactionManager;
- (void) startLocationService;
- (void) stopLocationService;

@property (nonatomic,strong) CLLocation *currentLocation;
-(BMKMapView*)getBaiDuMap;

@end
