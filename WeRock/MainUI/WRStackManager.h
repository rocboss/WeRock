//
//  WRStackManager.h
//  WeRock
//
//  Created by ZYVincent on 15/4/30.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WRStackManager : NSObject

@property (nonatomic,weak)UINavigationController *rootNav;

+ (WRStackManager *)shareManager;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (UIViewController *)popViewControllerAnimated:(BOOL)animated;

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated;

@end
