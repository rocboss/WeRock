//
//  WRMainViewController.m
//  WeRock
//
//  Created by ZYVincent on 15/4/27.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRMainViewController.h"
#import "WRTopicManager.h"
#import "WRHomeIndexViewController.h"
#import "WRTagIndexViewController.h"
#import "WRHotIndexViewController.h"
#import "WRTopicIndexViewController.h"

@interface WRMainViewController ()<GJCFAssetsPickerViewControllerDelegate>

@property (nonatomic,strong)NSMutableArray *currentSelectedImagesArray;

@end

@implementation WRMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViewControllers];
    
    self.currentSelectedImagesArray = [[NSMutableArray alloc]init];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];
}

- (void)setupSubViewControllers
{    
    WRTopicIndexViewController *topicVC = [[WRTopicIndexViewController alloc]init];
    WRBaseNavigationController *topicNav = [[WRBaseNavigationController alloc]initWithRootViewController:topicVC];
    
    WRHotIndexViewController *hotVC = [[WRHotIndexViewController alloc]init];
    WRBaseNavigationController *hotNav = [[WRBaseNavigationController alloc]initWithRootViewController:hotVC];

    WRTagIndexViewController *tagVC = [[WRTagIndexViewController alloc]init];
    WRBaseNavigationController *tagNav = [[WRBaseNavigationController alloc]initWithRootViewController:tagVC];

    WRHomeIndexViewController *homeVC = [[WRHomeIndexViewController alloc]init];
    WRBaseNavigationController *homeNav = [[WRBaseNavigationController alloc]initWithRootViewController:homeVC];

    self.viewControllers = @[topicNav,hotNav,tagNav,homeNav];

    NSArray *normalIcons = @[
                             @"icon_tabbar_chaticon_n",
                             @"icon_tabbar_contact_n",
                             @"icon_tabbar_essence_n",
                             @"icon_tabbar_jinba_n",
                             ];
    
    NSArray *selectedIcons = @[
                             @"icon_tabbar_chaticon_s",
                             @"icon_tabbar_contact_s",
                             @"icon_tabbar_essence_s",
                             @"icon_tabbar_jinba_s",
                             ];
    
    NSArray *titles = @[
                        @"帖子",
                        @"热门",
                        @"标签",
                        @"我的",
                        ];
    
    
    for (NSInteger index = 0; index < normalIcons.count; index ++) {
        
        UIImage *normalIcon = [UIImage imageNamed:[normalIcons objectAtIndex:index]];
        UIImage *selectIcon = [UIImage imageNamed:[selectedIcons objectAtIndex:index]];
        NSString *title = [titles objectAtIndex:index];
        
        WRBaseNavigationController *nav = [self.viewControllers objectAtIndex:index];
        nav.tabBarItem.title = title;
        nav.tabBarItem.image = normalIcon;
        nav.tabBarItem.selectedImage = selectIcon;
    }
    self.tabBar.tintColor = [WRGuideStyle mainThemeColor];
}

- (void)choosePicture
{
    GJCFAssetsPickerViewController *assetsPicker = [[GJCFAssetsPickerViewController alloc]init];
    assetsPicker.mutilSelectLimitCount = 4;
    assetsPicker.pickerDelegate = self;
    [self presentViewController:assetsPicker animated:YES completion:nil];
}

- (void)uploadPicture
{
    if (self.currentSelectedImagesArray.count == 0) {
        return;
    }
}

#pragma mark - pickerViewController delegate

- (void)pickerViewController:(GJCFAssetsPickerViewController *)pickerViewController didFinishChooseMedia:(NSArray *)resultArray
{
    [self.currentSelectedImagesArray removeAllObjects];
    [self.currentSelectedImagesArray addObjectsFromArray:resultArray];
    
    [pickerViewController dismissPickerViewController];
}

- (void)pickerViewController:(GJCFAssetsPickerViewController *)pickerViewController didReachLimitSelectedCount:(NSInteger)limitCount
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"超过限制%ld张数",limitCount] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)pickerViewControllerRequirePreviewButNoSelectedImage:(GJCFAssetsPickerViewController *)pickerViewController
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"请选择要预览的图片"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)pickerViewControllerPhotoLibraryAccessDidNotAuthorized:(GJCFAssetsPickerViewController *)pickerViewController
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"请授权访问你的相册"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

@end
