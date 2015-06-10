//
//  Created by marco on 25/05/13.
//
//
//


#import "MSSlideNavigationController.h"
#import "MSPanGestureRecognizer.h"
#import "UIView+ScreenShot.h"

@interface MSSlideNavigationController ()
@property(weak, nonatomic) UIViewController *currentViewController;
@property(weak, nonatomic) UIViewController *previousViewController;
@property(strong, nonatomic) UIImageView *currentViewControllerImageView;
@property(strong, nonatomic) UIImageView *previousViewControllerImageView;
@property(assign, nonatomic) CGRect originalFrame;
@property (assign, nonatomic) BOOL shouldDetect;

@property (strong, nonatomic) NSArray *currentLeftButtonItems;
@property (strong, nonatomic) NSArray *currentRightButtonItems;
@property (strong, nonatomic) NSMutableArray *previousLeftButtonItemViews;
@property (strong, nonatomic) NSMutableArray *previousRightButtonItemViews;
@end

@implementation MSSlideNavigationController

- (void)viewDidLoad
{
  MSPanGestureRecognizer *panGestureRecognizer = [[MSPanGestureRecognizer alloc] initWithTarget:self action:@selector(panFired:)];
  panGestureRecognizer.maximumNumberOfTouches = 1;
  [self.view addGestureRecognizer:panGestureRecognizer];
}

- (void)panFired:(MSPanGestureRecognizer *)panGestureRecognizer
{
  if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
    _shouldDetect = YES;
  }

  if (panGestureRecognizer.way != MSPanWayHorizontal && panGestureRecognizer.state != UIGestureRecognizerStateEnded) {
    return;
  }

  if (!_shouldDetect) {
    return;
  }

  if (panGestureRecognizer.state == UIGestureRecognizerStateBegan &&
    panGestureRecognizer.direction == MSPanDirectionRight) {
    _shouldDetect = NO;
    return;
  }

  if (self.viewControllers.count <= 1) {
    return;
  }

  if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
    [self prepareForSlide];
  }

  [self moveViewAndChangeNavButtonsWithGestureRecognizer:panGestureRecognizer];

  if (panGestureRecognizer.state == UIGestureRecognizerStateEnded ||
      panGestureRecognizer.state == UIGestureRecognizerStateCancelled ||
      panGestureRecognizer.state == UIGestureRecognizerStateFailed) {
    [self handleSlideEndedWithRecognizer:panGestureRecognizer];
  }
}

- (void)prepareForSlide
{
  NSUInteger nControllers = self.viewControllers.count;
  _currentViewController = self.visibleViewController;
  _previousViewController = self.viewControllers[nControllers - 2];
  _originalFrame = _currentViewController.view.frame;

  UIImage *currentViewControllerScreenShot = [_currentViewController.view screenShot];
  UIImage *previousViewControllerScreenShot = [_previousViewController.view screenShot];
  _currentViewControllerImageView = [[UIImageView alloc] initWithImage:currentViewControllerScreenShot];
  _previousViewControllerImageView = [[UIImageView alloc] initWithImage:previousViewControllerScreenShot];

  CGRect leftRect = _currentViewController.view.frame;
  leftRect.origin.x = leftRect.origin.x - leftRect.size.width;
  leftRect.origin.y = leftRect.origin.y - GJCFSystemNavigationBarHeight - GJCFSystemOriginYDelta;
  _previousViewControllerImageView.frame = leftRect;
  [_currentViewController.view addSubview:_currentViewControllerImageView];
  [_currentViewController.view addSubview:_previousViewControllerImageView];

}

- (UIBarButtonItem *)createCurrentBarButtonItemWithFrame:(CGRect)frame
{
  UIView *view = [[UIView alloc] initWithFrame:frame];
  [view addSubview:[[UIView alloc] initWithFrame:frame]];
  return [[UIBarButtonItem alloc] initWithCustomView:view];
}

#pragma mark - Handle gesture states

- (void)moveViewAndChangeNavButtonsWithGestureRecognizer:(MSPanGestureRecognizer *)panGestureRecognizer
{
  CGPoint translationPoint = [panGestureRecognizer translationInView:_currentViewController.view];
  CGRect currentFrame = _currentViewController.view.frame;
  currentFrame.origin.x = _originalFrame.origin.x + translationPoint.x;
  _currentViewController.view.frame = currentFrame;

  // fade bar button items
  float percentage = currentFrame.origin.x / currentFrame.size.width;
  [self setAlphaPercentageForBarButtonItems:percentage];

}

- (void)setAlphaPercentageForBarButtonItems:(float)percentage
{

}

- (void)handleSlideEndedWithRecognizer:(MSPanGestureRecognizer *)panGestureRecognizer
{
  CGPoint translationInView = [panGestureRecognizer translationInView:_currentViewController.view];
  CGPoint velocityInView = [panGestureRecognizer velocityInView:_currentViewController.view];
  CGFloat translationThreshold = _currentViewController.view.frame.size.width / 3;
  CGFloat velocityThreshold = 1000;

  if (panGestureRecognizer.direction == MSPanDirectionRight ||
    (translationInView.x < translationThreshold && velocityInView.x < velocityThreshold) ||
    _currentViewController.view.frame.origin.x < 0) {
    [self restoreToNormalState];
  }
  else {
    [UIView animateWithDuration:0.3 animations:^{
      CGRect frame = _currentViewController.view.frame;
      frame.origin.x = _currentViewController.view.frame.size.width;
      _currentViewController.view.frame = frame;
      [self setAlphaPercentageForBarButtonItems:1];

    }                completion:^(BOOL finished) {
      [self popViewControllerAnimated:NO];
    }];
  }
}

#pragma mark - Clean up

- (void)restoreToNormalState
{
  [UIView animateWithDuration:0.3 animations:^{
    CGRect frame = _currentViewController.view.frame;
    frame.origin.x = 0;
    _currentViewController.view.frame = frame;
    [self setAlphaPercentageForBarButtonItems:0];
  }                completion:^(BOOL finished) {
    [self removeScreenShots];
    [self clean];
  }];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
  [self clean];
  return [super popViewControllerAnimated:animated];
}

- (void)removeScreenShots
{
  [_currentViewControllerImageView removeFromSuperview];
  [_previousViewControllerImageView removeFromSuperview];
}

- (void)clean
{
  _currentViewController = nil;
  _previousViewController = nil;
  _currentViewControllerImageView = nil;
  _previousViewControllerImageView = nil;

  _previousLeftButtonItemViews = nil;
  _previousRightButtonItemViews = nil;
  _currentLeftButtonItems = nil;
  _currentRightButtonItems = nil;
}

@end