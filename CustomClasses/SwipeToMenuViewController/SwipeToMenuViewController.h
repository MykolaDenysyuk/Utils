//
//  SwipeToMenuViewController.h
//  Utils
//
//  Created by Mykola Denysyuk on 12/3/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeToMenuViewController : UIViewController

@property (readonly, nonatomic) UIScrollView * scrollView;
@property (readonly, nonatomic) UIView * leftContainerView;
@property (readonly, nonatomic) UIView * centralContainerView;
@property (readonly, nonatomic) UIView * rightContainerView;

- (void)willScrollToLeftContainer;
- (void)didScrollToLeftContainer;
- (void)willScrollToCentralContainer;
- (void)didScrollToCentralContainer;
- (void)willScrollToRightContainer;
- (void)didScrollToRightContainer;

@end
