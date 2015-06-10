//
//  AppDelegate.m
//  WeRock
//
//  Created by ZYVincent on 15/4/24.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "WRMainViewController.h"
#import "WRStackManager.h"
#import "MSSlideNavigationController.h"
#import "WRUserCenter.h"

@interface AppDelegate ()

@property (nonatomic,strong)MSSlideNavigationController *rootNav;

@property (nonatomic,strong)WRUserCenter *userCenter;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [self loginUser];
    
    WRMainViewController *rootVC = [[WRMainViewController alloc]init];
    self.rootNav = [[MSSlideNavigationController alloc]initWithRootViewController:rootVC];
    [self setNavigationBarImage];
    [[WRStackManager shareManager]setRootNav:self.rootNav];
    self.window.rootViewController = self.rootNav;
    

    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)loginUser
{
    self.userCenter = [[WRUserCenter alloc]init];
    WRUserModel *user = [[WRUserModel alloc]init];
    user.password = @"mike5262705";
    user.email = @"hutao5262705@hotmail.com";
    
    [self.userCenter loginUser:user withResult:^(BOOL status, NSArray *resultModelArray, NSString *msg) {
        
    }];
}

//设置导航图片
-(void)setNavigationBarImage
{
    if (GJCFSystemIsOver7) {
        UIImage *syncBgImg = [GJCFAssetsPickerConstans imageForColor:[WRGuideStyle navigationBarBackColor] withSize:CGSizeMake(320, 64)];
        [self.rootNav.navigationBar setBackgroundImage:syncBgImg forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    else if (GJCFSystemIsOver6)
    {
        UIImage *syncBgImg = [GJCFAssetsPickerConstans imageForColor:[WRGuideStyle navigationBarBackColor] withSize:CGSizeMake(320, 44)];
        [self.rootNav.navigationBar setBackgroundImage:syncBgImg forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.rootNav.navigationBar setBackgroundImage:[GJCFAssetsPickerConstans imageForColor:[WRGuideStyle navigationBarBackColor] withSize:CGSizeMake(320, 44)] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
