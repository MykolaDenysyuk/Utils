//
//  SwipeToMenuViewController.m
//  Utils
//
//  Created by Mykola Denysyuk on 12/3/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import "SwipeToMenuViewController.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SIDE_CONTAINER_WIDTH 280.0f
#define kPRECISION 30.0f
#define kANIMATION_DURATION 0.2f
#define kSIDE_MENU_SHIFT 100.f
#define kDIMMING_FACTOR 1.3f

@interface SwipeToMenuViewController () <UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
}

@property (nonatomic) CGPoint lastContentOffset;

@end

@implementation SwipeToMenuViewController

- (void)loadView
{
    _scrollView = [UIScrollView new];
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = _scrollView.showsVerticalScrollIndicator = NO;
    self.view = _scrollView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _leftContainerView = [UIView new];
    [self.view addSubview:_leftContainerView];
    _centralContainerView = [UIView new];
    _rightContainerView = [UIView new];
    [self.view addSubview:_rightContainerView];
    [self.view addSubview:_centralContainerView];
    
    self.centralContainerView.backgroundColor = [UIColor whiteColor];
    self.leftContainerView.backgroundColor = [UIColor lightGrayColor];
    self.rightContainerView.backgroundColor = [UIColor grayColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.centralContainerView.frame = CGRectMake(SIDE_CONTAINER_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.leftContainerView.frame = CGRectMake(0, 0, SIDE_CONTAINER_WIDTH, SCREEN_HEIGHT);
    self.rightContainerView.frame = CGRectMake(SCREEN_WIDTH + SIDE_CONTAINER_WIDTH, 0, SIDE_CONTAINER_WIDTH, SCREEN_HEIGHT);
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.centralContainerView.frame) + CGRectGetWidth(self.leftContainerView.frame) + CGRectGetWidth(self.rightContainerView.frame), SCREEN_HEIGHT);
    
    [self scrollToCentralContainer];
}

#pragma mark - UIScrollViewController delegate:

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    *targetContentOffset = scrollView.contentOffset;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat leftContainerOffsetProgress = 1.f;
    if (scrollView.contentOffset.x < SIDE_CONTAINER_WIDTH) {
        leftContainerOffsetProgress = scrollView.contentOffset.x/SIDE_CONTAINER_WIDTH;
    }
    self.leftContainerView.center = CGPointMake(SIDE_CONTAINER_WIDTH/2 + leftContainerOffsetProgress * kSIDE_MENU_SHIFT, self.leftContainerView.center.y);
    self.leftContainerView.alpha = kDIMMING_FACTOR-leftContainerOffsetProgress;
    
    CGFloat rightContainerOffsetProgress = 1.f;
    if (scrollView.contentOffset.x > SIDE_CONTAINER_WIDTH) {
        rightContainerOffsetProgress = (scrollView.contentOffset.x - SIDE_CONTAINER_WIDTH)/SIDE_CONTAINER_WIDTH;
        rightContainerOffsetProgress = 1-rightContainerOffsetProgress;
    }
    self.rightContainerView.center = CGPointMake(SCREEN_WIDTH + 1.5*SIDE_CONTAINER_WIDTH - rightContainerOffsetProgress * kSIDE_MENU_SHIFT, self.rightContainerView.center.y);
    self.rightContainerView.alpha = kDIMMING_FACTOR-rightContainerOffsetProgress;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    
    if (contentOffsetX == 0)
        return;
    
    if (self.lastContentOffset.x == 0 && contentOffsetX > kPRECISION)                                           // slide to right from left container ...
        [self scrollToCentralContainer];
    else if (self.lastContentOffset.x == SIDE_CONTAINER_WIDTH && contentOffsetX < (SIDE_CONTAINER_WIDTH - kPRECISION))    // slide to left from center ...
        [self scrollToLeftContainer];
    else if (self.lastContentOffset.x == SIDE_CONTAINER_WIDTH && contentOffsetX > (SIDE_CONTAINER_WIDTH + kPRECISION))    // slide to right from center ...
        [self scrollToRightContainer];
    else if (self.lastContentOffset.x == 2*SIDE_CONTAINER_WIDTH && contentOffsetX < (2*SIDE_CONTAINER_WIDTH - kPRECISION))// slide to left from right container ...
        [self scrollToCentralContainer];
    else
        [self scrollTo:self.lastContentOffset completion:nil];
}

- (void)scrollTo:(CGPoint)origin completion:(void(^)(BOOL finished))completion
{
    _lastContentOffset = origin;
    
    [UIView animateWithDuration:kANIMATION_DURATION
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.scrollView.contentOffset = origin;
                     }
                     completion:^(BOOL finished) {
                         if (completion) {
                             completion(finished);
                         }
                     }];
}

- (void)scrollToCentralContainer
{
    [self willScrollToCentralContainer];
    [UIView animateWithDuration:kANIMATION_DURATION
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.rightContainerView.center = CGPointMake(SIDE_CONTAINER_WIDTH/2 + kSIDE_MENU_SHIFT, self.rightContainerView.center.y);
                         self.leftContainerView.center = CGPointMake(SCREEN_WIDTH + 1.5*SIDE_CONTAINER_WIDTH - kSIDE_MENU_SHIFT, self.leftContainerView.center.y);
                     }
                     completion:nil];
    typeof(self) __weak weakSelf = self;
    [self scrollTo:CGPointMake(SIDE_CONTAINER_WIDTH, 0)
        completion:^(BOOL finished) {
            if (finished) {
                [weakSelf didScrollToCentralContainer];
            }
        }];
}

- (void)scrollToLeftContainer
{
    [self willScrollToLeftContainer];
    [UIView animateWithDuration:kANIMATION_DURATION
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.rightContainerView.center = CGPointMake(SIDE_CONTAINER_WIDTH/2, self.rightContainerView.center.y);
                     }
                     completion:nil];
    typeof(self) __weak weakSelf = self;
    [self scrollTo:CGPointZero
        completion:^(BOOL finished) {
            if (finished) {
                [weakSelf didScrollToLeftContainer];
            }
        }];
}

- (void)scrollToRightContainer
{
    [self willScrollToRightContainer];
    [UIView animateWithDuration:kANIMATION_DURATION
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.leftContainerView.center = CGPointMake(SCREEN_WIDTH + 1.5*SIDE_CONTAINER_WIDTH, self.leftContainerView.center.y);
                     }
                     completion:nil];
    typeof(self) __weak weakSelf = self;
    [self scrollTo:CGPointMake(2*SIDE_CONTAINER_WIDTH, 0)
        completion:^(BOOL finished) {
            if (finished) {
                [weakSelf didScrollToRightContainer];
            }
        }];
}

#pragma mark - For Subclasses:

- (void)willScrollToLeftContainer
{
    
}

- (void)didScrollToLeftContainer
{
    
}

- (void)willScrollToCentralContainer
{
    
}

- (void)didScrollToCentralContainer
{
    
}

- (void)willScrollToRightContainer
{
    
}

- (void)didScrollToRightContainer
{
    
}

@end
