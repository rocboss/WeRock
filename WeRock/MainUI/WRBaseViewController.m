//
//  GJGCBaseViewController.m
//  GJGroupChat
//
//  Created by lijunjie on 14/10/24.
//  Copyright (c) 2014年 ganji. All rights reserved.
//

#import "WRBaseViewController.h"
#import "GJCFAssetsPickerConstans.h"

@interface WRBaseViewController ()
{
    UIButton *_leftButton;
    UIButton *_rightButton;
    BOOL _isPop;
}

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation WRBaseViewController
@synthesize strNavTitle = _strNavTitle;
@synthesize titleLabel = _titleLabel;
@synthesize isTransparent = _isTransparent;

@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;

- (void)dealloc
{
    NSLog(@"%@ 释放了！！！",[self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isPop = NO;
    [self.view setBackgroundColor:[WRGuideStyle mainBackgroundColor]];
    // Do any additional setup after loading the view.
    
    /* 初始化加载特效 */
    self.statusHUD = [[WRLoadingStatusHUD alloc]initWithView:self.view];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

//设置navbar的标题
- (void)setStrNavTitle:(NSString *)navTitle
{
    _strNavTitle = navTitle;
    UIView* navTitleView = (self.navigationItem.titleView);
    
    
    if([navTitleView isKindOfClass:[UILabel class]])//先要判断是否为label
    {
        self.titleLabel = (UILabel*)navTitleView;
        self.titleLabel.text = navTitle;
    }
    else
    {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.text= navTitle;
        self.navigationItem.titleView = _titleLabel;
    }
    
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [WRGuideStyle navigationBarTitleFont];
    self.titleLabel.textColor = [WRGuideStyle navigationBarTitleColor];
    [self.titleLabel sizeToFit];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    //非根视图默认添加返回按钮
    if ([self.navigationController.viewControllers count] > 0
        && self != [self.navigationController.viewControllers objectAtIndex:0])
    {
        [self setLeftButtonWithImageName:@"标题栏-icon-左箭头-返回" bgImageName:nil];
    }
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"内存不足:%@",[self class]);
    NSLog(@"内存不足:%@",[self class]);
}

-(void)setNavTitleColor:(UIColor*)titleColor
{
    self.titleLabel.textColor = titleColor;
}

//设置导航左边的button的图片名和背景图片名
- (void)setLeftButtonWithImageName:(NSString*)imageName bgImageName:(NSString*)bgImageName
{
    UIButton *tmpLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    tmpLeftButton.frame = CGRectMake(-5, 0, 30, 32);//CGRectMake(0, BUTTONMarginUP, NAVBUTTON_WIDTH, NAVBUTTON_HEIGHT);
    tmpLeftButton.showsTouchWhenHighlighted = NO;
    tmpLeftButton.exclusiveTouch = YES; //add by ljj 修改push界面问题
    
    if (bgImageName)//设置button的背景
    {
        [tmpLeftButton setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    
    [tmpLeftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tmpLeftButton addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.leftButton = tmpLeftButton;
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tmpLeftButton];
    
    if (GJCFSystemIsOver7)//左边button的偏移量，从左移动13个像素
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -10;
        [self.navigationItem setLeftBarButtonItems:@[negativeSeperator, leftButtonItem]];
    }
    else
    {
        [self.navigationItem setLeftBarButtonItem:leftButtonItem];
    }
}

- (void)setRightButtonWithTitle:(NSString*)title
{
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:20.0] constrainedToSize:CGSizeMake(MAXFLOAT, 44)];
    if (size.width<60) {
        size.width = 60;
    }
    else
    {
        size.width+=6;
    }
    UIButton *tmpRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tmpRightButton.frame = CGRectMake(self.view.frame.size.width-NAVBUTTON_WIDTH-BUTTONMarginX, BUTTONMarginUP, size.width, 30);
    
    tmpRightButton.showsTouchWhenHighlighted = NO;
    tmpRightButton.exclusiveTouch = YES;//add by ljj 修改push界面问题
    
    [tmpRightButton addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [tmpRightButton setTitleColor:GJCFQuickRGBColor(255.f, 255.f, 255.f) forState:UIControlStateNormal];
    [tmpRightButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [tmpRightButton setTitle:title forState:UIControlStateNormal];
    
    [tmpRightButton setTitleColor:GJCFQuickRGBColor(200, 200, 200) forState:UIControlStateDisabled];
    
    [tmpRightButton setTitleColor:GJCFQuickRGBColor(200, 200, 200) forState:UIControlStateHighlighted];
    
    self.rightButton = tmpRightButton;
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tmpRightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    if (GJCFSystemIsOver7)//左边button的偏移量，从左移动13个像素
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -10;
        [self.navigationItem setRightBarButtonItems:@[negativeSeperator, rightButtonItem]];
    }
    else
    {
        [self.navigationItem setRightBarButtonItem:rightButtonItem];
    }
}

- (void)setRightButtonWithDefaultImageName:(NSString*)title;
{
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:20.0] constrainedToSize:CGSizeMake(MAXFLOAT, 44)];
    if (size.width<60) {
        size.width = 60;
    }
    else
    {
        size.width+=6;
    }
    UIButton *tmpRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tmpRightButton.frame = CGRectMake(self.view.frame.size.width-NAVBUTTON_WIDTH-BUTTONMarginX, BUTTONMarginUP, size.width, 30);
    
    tmpRightButton.showsTouchWhenHighlighted = NO;
    tmpRightButton.exclusiveTouch = YES;//add by ljj 修改push界面问题
    
    [tmpRightButton addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [tmpRightButton setBackgroundImage:[[UIImage imageNamed:@"button34px"] stretchableImageWithLeftCapWidth:6 topCapHeight:6] forState:UIControlStateNormal];
    [tmpRightButton setTitleColor:GJCFQuickRGBColor(255.f, 255.f, 255.f) forState:UIControlStateNormal];
    [tmpRightButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [tmpRightButton setTitle:title forState:UIControlStateNormal];
    
    UIImage* grayImage = [[UIImage imageNamed:@"button34px"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    [tmpRightButton setBackgroundImage:grayImage forState:UIControlStateDisabled];
    [tmpRightButton setTitleColor:GJCFQuickRGBColor(200, 200, 200) forState:UIControlStateDisabled];
    
    [tmpRightButton setBackgroundImage:grayImage forState:UIControlStateHighlighted];
    [tmpRightButton setTitleColor:GJCFQuickRGBColor(200, 200, 200) forState:UIControlStateHighlighted];
    
    self.rightButton = tmpRightButton;
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tmpRightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    if (GJCFSystemIsOver7)//左边button的偏移量，从左移动13个像素
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -10;
        [self.navigationItem setRightBarButtonItems:@[negativeSeperator, rightButtonItem]];
    }
    else
    {
        [self.navigationItem setRightBarButtonItem:rightButtonItem];
    }
}

//设置导航右边的button的图片名和背景图片名
- (void)setRightButtonWithImageName:(NSString*)imageName bgImageName:(NSString*)bgImageName
{
    UIButton *tmpRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tmpRightButton.frame = CGRectMake(self.view.frame.size.width-NAVBUTTON_WIDTH-BUTTONMarginX, BUTTONMarginUP, NAVBUTTON_WIDTH, NAVBUTTON_HEIGHT);
    
    tmpRightButton.showsTouchWhenHighlighted = NO;
    tmpRightButton.exclusiveTouch = YES;//add by ljj 修改push界面问题
    
    if (bgImageName && bgImageName.length>0)//设置button的背景
    {
        [tmpRightButton setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    
    [tmpRightButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tmpRightButton addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton = tmpRightButton;
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tmpRightButton];
    
    if (GJCFSystemIsOver7)//左边button的偏移量，从左移动13个像素
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -10;
        [self.navigationItem setRightBarButtonItems:@[negativeSeperator, rightButtonItem]];
    }
    else
    {
        [self.navigationItem setRightBarButtonItem:rightButtonItem];
    }
}

-(void)setRightButtonWithStateImage:(NSString*)normaimageName stateHighlightedImage:(NSString*)highlightedImage stateDisabledImage:(NSString*)disabledImage titleName:(NSString*)titleName
{
    UIButton *tmpRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tmpRightButton.exclusiveTouch = YES;//add by ljj 修改push界面问题
    
    tmpRightButton.frame = CGRectMake(self.view.frame.size.width-NAVBUTTON_WIDTH-BUTTONMarginX, BUTTONMarginUP, NAVBUTTON_WIDTH, NAVBUTTON_HEIGHT);
    if (titleName) {
        [tmpRightButton setTitle:titleName forState:UIControlStateNormal];
        [tmpRightButton setTitle:titleName forState:UIControlStateDisabled];
    }
    tmpRightButton.showsTouchWhenHighlighted = NO;
    [tmpRightButton setImage:[UIImage imageNamed:normaimageName] forState:UIControlStateNormal];
    [tmpRightButton setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [tmpRightButton setImage:[UIImage imageNamed:disabledImage] forState:UIControlStateDisabled];
    
    [tmpRightButton addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton = tmpRightButton;
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tmpRightButton];
    
    if (GJCFSystemIsOver7)//左边button的偏移量，从左移动13个像素
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -10;
        [self.navigationItem setRightBarButtonItems:@[negativeSeperator, rightButtonItem]];
    }
    else
    {
        [self.navigationItem setRightBarButtonItem:rightButtonItem];
    }
}

/**
 *  在右边的项目中添加新的icon
 *
 *  @param button
 *  @param state  
 */
- (void)appendRightBarItemWithCustomButton:(UIButton *)button toOldLeft:(BOOL)state
{
    NSMutableArray *oldRightBarItems = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    
    UIBarButtonItem *rightNewItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    if (state) {
        
        [oldRightBarItems addObject:rightNewItem];
        
        self.navigationItem.rightBarButtonItems = oldRightBarItems;
        
        return;
    }
    
    [oldRightBarItems insertObject:rightNewItem atIndex:0];
    
    self.navigationItem.rightBarButtonItems = oldRightBarItems;
}

//导航设置为透明
-(void)clearNavigationBar
{
    if (GJCFSystemIsOver7) {
        self.navigationController.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController.navigationBar setBackgroundImage:[GJCFAssetsPickerConstans imageForColor:[UIColor clearColor] withSize:CGSizeMake(320, 64)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    else if (GJCFSystemIsOver7)
    {
        self.navigationController.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController.navigationBar setBackgroundImage:[GJCFAssetsPickerConstans imageForColor:[UIColor clearColor] withSize:CGSizeMake(320, 44)] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[GJCFAssetsPickerConstans imageForColor:[UIColor clearColor] withSize:CGSizeMake(320, 43)] forBarMetrics:UIBarMetricsDefault];
    }
    
    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)])
    {
        [self.navigationController.navigationBar setShadowImage:[GJCFAssetsPickerConstans imageForColor:[UIColor clearColor] withSize:CGSizeMake(320, 3)]];
    }
}

//设置导航图片
-(void)setNavigationBarImage
{
    if (GJCFSystemIsOver7) {
        UIImage *syncBgImg = [GJCFAssetsPickerConstans imageForColor:[UIColor greenColor] withSize:CGSizeMake(320, 64)];
        [self.navigationController.navigationBar setBackgroundImage:syncBgImg forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    else if (GJCFSystemIsOver6)
    {
        UIImage *syncBgImg = [GJCFAssetsPickerConstans imageForColor:[UIColor greenColor] withSize:CGSizeMake(320, 44)];
        [self.navigationController.navigationBar setBackgroundImage:syncBgImg forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[GJCFAssetsPickerConstans imageForColor:[UIColor greenColor] withSize:CGSizeMake(320, 43)] forBarMetrics:UIBarMetricsDefault];
    }
    
    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)])
    {
        [self.navigationController.navigationBar setShadowImage:[GJCFAssetsPickerConstans imageForColor:[UIColor greenColor] withSize:CGSizeMake(320, 3)]];
    }
}

//将UIImage缩放到指定大小尺寸
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (NSString *)rightButtonName
{
    return [self.rightButton titleForState:UIControlStateNormal];
}

//设置左边按钮的显示or隐藏状态
- (void)setLeftButtonHiden:(BOOL)hiden
{
    if (self.leftButton) {
        [self.leftButton setHidden:hiden];
    }
}

- (void)setLeftButtonEnabled:(BOOL)enabled
{
    [self.leftButton setEnabled:enabled];
}
//设置右边按钮的显示or隐藏状态
- (void)setRightButtonHiden:(BOOL)hiden
{
    if (self.rightButton) {
        [self.rightButton setHidden:hiden];
    }
}

- (void)setRightButtonEnabled:(BOOL)enabled
{
    [self.rightButton setEnabled:enabled];
}


//导航左按钮点击事件
- (void)leftButtonPressed:(id)sender
{
    if (_isPop) {
        return;
    }
    _isPop = YES;
    UIViewController *vc = [self.navigationController popViewControllerAnimated:YES];
    if (vc == nil) {
        [self  dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

//设置导航可以透明
-(void)setIsTransparent:(BOOL)isTransparent
{
    if (isTransparent)//透明
    {
        [self clearNavigationBar];
    }
    else//不透明
    {
        [self setNavigationBarImage];
    }
}

//导航右按钮点击事件
- (void)rightButtonPressed:(id)sender{}



#pragma mark-旋屏的方法设置

//返回该controller支持的设备状态
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

//设置该controller是否可自动旋屏
- (BOOL)shouldAutorotate
{
    return NO;
}

//为了兼容IOS6以前的版本而保留的方法
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}


//当发送旋屏事件后，就会掉用该方法
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration NS_AVAILABLE_IOS(3_0)
{
    
}

@end
