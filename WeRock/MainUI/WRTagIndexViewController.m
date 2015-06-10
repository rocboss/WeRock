//
//  WRTagIndexViewController.m
//  WeRock
//
//  Created by ZYVincent on 15/4/30.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRTagIndexViewController.h"
#import "WRTopicIndexViewController.h"

@interface WRTagIndexViewController ()

@end

@implementation WRTagIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setStrNavTitle:@"标签"];

    UIButton *push = [TVGDebugQuickUI buttonAddOnView:self.view title:@"push" target:self selector:@selector(push)];
    push.gjcf_left = 30;
    push.gjcf_top = 80;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor orangeColor];
    imageView.gjcf_width = 300;
    imageView.gjcf_height = 265;
    imageView.gjcf_left = 50;
    imageView.gjcf_top = 130;
    [self.view addSubview:imageView];
}

- (void)push
{
    WRTopicIndexViewController *baseVC = [[WRTopicIndexViewController alloc]init];
    
    [[WRStackManager shareManager]pushViewController:baseVC animated:YES];
}
@end
