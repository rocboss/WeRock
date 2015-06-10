//
//  WRHeadView.m
//  WeRock
//
//  Created by ZYVincent on 15/4/30.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRHeadView.h"

@interface WRHeadView ()

@property (nonatomic,strong)GJCUAsyncImageView *contentImageView;

@end

@implementation WRHeadView

- (instancetype)init
{
    if (self = [super init]) {
        
        self.contentImageView = [[GJCUAsyncImageView alloc]init];
        [self addSubview:self.contentImageView];
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.contentImageView.gjcf_size = frame.size;
    self.contentImageView.gjcf_origin = CGPointMake(0, 0);
}

- (void)setHeadUrl:(NSString *)url
{
    [self.contentImageView setUrl:url];
}

@end
