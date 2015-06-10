//
//  GJGCBaseViewController.h
//  GJGroupChat
//
//  Created by lijunjie on 14/10/24.
//  Copyright (c) 2014年 ganji. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WRLoadingStatusHUD.h"

#define BUTTONMarginX    10
#define BUTTONMarginUP   0
#define NAVBUTTON_WIDTH  44
#define NAVBUTTON_HEIGHT 44
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define NAVIGATION_BAR_HEIGHT self.navigationController.navigationBar.frame.size.height

@interface WRBaseViewController : UIViewController
{
    UILabel *_titleLabel;//导航视图的title
    NSString *_strNavTitle;//导航标题
    BOOL _isTransparent;  /**< 导航设置透明*/
}

@property (strong, nonatomic) NSString *strNavTitle;
@property (strong, nonatomic) UILabel *titleLabel;
@property (assign, nonatomic) BOOL isTransparent;
@property (nonatomic,strong)WRLoadingStatusHUD *statusHUD;

/**
 *  设置标题字体颜色
 *
 *  @param titleColor 标题颜色
 */
-(void)setNavTitleColor:(UIColor*)titleColor;

/**
 *	@brief	设置导航左边的button的图片名和背景图片名
 *
 *	@param 	imageName 	button的图片名
 *	@param 	bgImageName 	button的背景图片名
 */
- (void)setLeftButtonWithImageName:(NSString*)imageName bgImageName:(NSString*)bgImageName;

/**
 *  创建右边按钮没有图片
 *
 *  @param title 设置右边按钮的title
 */
- (void)setRightButtonWithTitle:(NSString*)title;

/**
 * 设置导航右边的button的title
 *
 *  @param title 设置button的title
 */
- (void)setRightButtonWithDefaultImageName:(NSString*)title;

/**
 *	@brief	设置导航右边的button的图片名和背景图片名
 *
 *	@param 	imageName 	button的图片名
 *	@param 	bgImageName 	button的背景图片名
 */
- (void)setRightButtonWithImageName:(NSString*)imageName bgImageName:(NSString*)bgImageName;
/**
 *  设置导航右边的button
 *
 *  @param normaimageName   设置默认状态的图片
 *  @param highlightedImage 设置按下状态的图片
 *  @param disabledImage    设置不可点击状态的图片
 */
-(void)setRightButtonWithStateImage:(NSString*)normaimageName stateHighlightedImage:(NSString*)highlightedImage stateDisabledImage:(NSString*)disabledImage titleName:(NSString*)titleName;

/**
 *	@brief	返回右边按钮的名字
 *
 */
- (NSString *)rightButtonName;

/**
 *	@brief	设置左边按钮的显示or隐藏状态
 *
 *	@param 	hiden 	YES 隐藏 NO 显示
 */
- (void)setLeftButtonHiden:(BOOL)hiden;
/**
 *  设置左边按钮的可用or不可用
 *
 *  @param enabled YES 可用 NO 不可用
 */
- (void)setLeftButtonEnabled:(BOOL)enabled;
/**
 *	@brief	设置右边按钮的显示or隐藏状态
 *
 *	@param 	hiden 	YES 隐藏 NO 显示
 */
- (void)setRightButtonHiden:(BOOL)hiden;

/**
 *  设置右侧按钮是否点击
 *
 *  @param enabled YES 可用   NO 不可用
 */
- (void)setRightButtonEnabled:(BOOL)enabled;

/**
 *  向导航栏右边添加一个item,在原来的项的右边还是左边
 *
 *  @param button
 *  @param state
 */
- (void)appendRightBarItemWithCustomButton:(UIButton *)button toOldLeft:(BOOL)state;

/*=====================下面的方法需要子类去实现，导航的左按钮时间默认是pop到上一级========================*/

//导航左按钮点击事件
- (void)leftButtonPressed:(id)sender;

//导航右按钮点击事件
- (void)rightButtonPressed:(id)sender;

@end
