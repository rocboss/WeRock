//
//  GJCFLocationManager.m
//  GJCommonFoundation
//
//  Created by zhangv on 14-10-20.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import "GJCFLocationManager.h"

BMKMapManager* _mapManager;
@implementation GJCFLocationManager
+(GJCFLocationManager*) sharedManager
{
    static GJCFLocationManager *_locationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
//        _mapManager = [[BMKMapManager alloc] init];
        
        _locationManager = [[self alloc] init];
        
    });
    return _locationManager;
}
-(void) initBaiduAPPKey:(NSString*)key{
    
//    BOOL ret = [_mapManager start:@"1ZaebgYst677VCNOrd1ynRWg" generalDelegate:self];
    BOOL ret = NO;

    if (!ret) {
        NSLog(@"manager start failed!");
    }
    _currentLocation = nil;
    _currentLocation = [[CLLocation alloc] init];
    _locService = nil;
    _locService = [[BMKLocationService alloc]init];
    
    _locService.delegate = self;

    [self getBaiDuMap];
}

-(void)initSystemLoactionManager
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy  = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}
-(void)copy:(id)sender
{
    return;
}
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    self.currentLocation = newLocation;
}

#pragma Location Service

- (void) startLocationService
{
    NSLog(@"进入普通定位态");
    [_locService startUserLocationService];
}
- (void) stopLocationService
{
    NSLog(@"停止更新用户位置");
    [_locService stopUserLocationService];
}

#pragma location service Delegate
/**
 *在将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser
{
    NSLog(@"willStartLocatingUser");
}
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    self.currentLocation = [[CLLocation alloc] initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
    
    NSDictionary *userDic = @{@"UserLocation":userLocation};
    [[NSNotificationCenter defaultCenter] postNotificationName:GJCF_NOTIFICATION_CHANGE_LOCALTION object:nil userInfo:userDic];
}

-(BMKMapView*)getBaiDuMap
{
    BMKMapView *_mapView = [[BMKMapView alloc] init];
    [_mapView setZoomLevel:16];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
    return _mapView;
}


#pragma baiduMap appkey general
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

@end
