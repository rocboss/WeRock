//
//  WRStackManager.m
//  WeRock
//
//  Created by ZYVincent on 15/4/30.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRStackManager.h"

@implementation WRStackManager

+ (WRStackManager *)shareManager
{
    static WRStackManager *_stackManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _stackManager = [[self alloc]init];
        
    });
    
    return _stackManager;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.rootNav pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
  return [self.rootNav popViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    return [self.rootNav popToViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    return [self.rootNav popToRootViewControllerAnimated:animated];
}

@end
