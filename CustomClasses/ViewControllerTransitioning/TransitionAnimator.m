//
//  TransitionAnimator.m
//  BlurredPopover
//
//  Created by Mykola Denysyuk on 1/31/16.
//  Copyright © 2016 Mykola Denysyuk. All rights reserved.
//

#import "TransitionAnimator.h"
#import <UIKit/UIKit.h>

@implementation TransitionAnimator

#pragma mark - Initialization:

- (instancetype)init {
    if (self = [super init]) {
        _transitionDuration = UINavigationControllerHideShowBarDuration;
    }
    return self;
}

- (instancetype)initWithTransitionDuration:(NSTimeInterval)duration animationBlock:(AnimateTransitionBlock)block {
    if (self = [self init]) {
        _transitionDuration = duration;
        _transitionAnimationBlock = block;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning:

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.transitionDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    _fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    _containerView = [transitionContext containerView];
    if (UITransitionContextFromViewKey) {
        _fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        _toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        _fromView = _fromViewController.view;
        _toView = _toViewController.view;
    }
    
    [_containerView addSubview:_toView];
    
    if (self.transitionAnimationBlock) {
        self.transitionAnimationBlock(self);
    }
}

@end
