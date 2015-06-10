//
//  GJCFPOIInfo.m
//  GJCommonFoundation
//
//  Created by zhangv on 14-10-20.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

#import "GJCFPOIInfo.h"

@implementation GJCFPOIInfo
-(id)initWithBMKPoiInfo:(BMKPoiInfo*) bmkpoiInfo
{
    self = [super init];
    if (self) {
        self.name = bmkpoiInfo.name;
        self.uid =bmkpoiInfo.uid;
        self.address = bmkpoiInfo.address;
        self.city = bmkpoiInfo.city;
        self.phone = bmkpoiInfo.phone;
        self.postcode = bmkpoiInfo.postcode;
        self.epoitype = bmkpoiInfo.epoitype;
        self.pt = bmkpoiInfo.pt;
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        self.address = [dict objectForKey:@"address"];
        self.name = [dict objectForKey:@"name"];
        CGFloat lat = [[[dict objectForKey:@"location"] objectForKey:@"lat"] floatValue];
        CGFloat lng = [[[dict objectForKey:@"location"] objectForKey:@"lng"] floatValue];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
        self.pt = location.coordinate;
    }
    return self;
}

@end
