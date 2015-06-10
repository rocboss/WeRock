//
//  GJGCLoadingStatusHUD.h
//  GJGroupChat
//
//  Created by ZYVincent on 15-1-9.
//  Copyright (c) 2015年 ganji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WRLoadingStatusHUD : UIView

- (instancetype)initWithView:(UIView *)aView;

- (void)showWithStatusText:(NSString *)status;

- (void)dismiss;

@end
