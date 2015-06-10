//
//  GJGCBaseNavigationController.m
//  GJGroupChat
//
//  Created by lijunjie on 14/10/27.
//  Copyright (c) 2014年 ganji. All rights reserved.
//

#import "WRBaseNavigationController.h"

@interface WRBaseNavigationController ()

@end

@implementation WRBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarImage];
    // Do any additional setup after loading the view.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

//设置导航图片
-(void)setNavigationBarImage
{
    if (GJCFSystemIsOver7) {
        UIImage *syncBgImg = [GJCFAssetsPickerConstans imageForColor:[WRGuideStyle navigationBarBackColor] withSize:CGSizeMake(320, 64)];
        [self.navigationBar setBackgroundImage:syncBgImg forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    else if (GJCFSystemIsOver6)
    {
        UIImage *syncBgImg = [GJCFAssetsPickerConstans imageForColor:[WRGuideStyle navigationBarBackColor] withSize:CGSizeMake(320, 44)];
        [self.navigationBar setBackgroundImage:syncBgImg forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationBar setBackgroundImage:[GJCFAssetsPickerConstans imageForColor:[WRGuideStyle navigationBarBackColor] withSize:CGSizeMake(320, 44)] forBarMetrics:UIBarMetricsDefault];
    }
}

@end
