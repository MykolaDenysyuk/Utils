//
//  AnimatedTransitionProvider.m
//  BlurredPopover
//
//  Created by Mykola Denysyuk on 1/31/16.
//  Copyright © 2016 Mykola Denysyuk. All rights reserved.
//

#import "AnimatedTransitionProvider.h"

@implementation AnimatedTransitionProvider

#pragma mark - Initialization:

- (instancetype)initWithPresentedAnimator:(id<UIViewControllerAnimatedTransitioning>)presentedAnimator withDismissalAnimator:(id<UIViewControllerAnimatedTransitioning>)dismissalAnimator withPresentedInteractor:(id<UIViewControllerInteractiveTransitioning>)presentedInteractor withDismissalInteractor:(id<UIViewControllerInteractiveTransitioning>)dismissalInteractor {
    if (self = [self init]) {
        _presentedAnimator = presentedAnimator;
        _dismissalAnimator = dismissalAnimator;
        _presentedInteractor = presentedInteractor;
        _dismissalInteractor = dismissalInteractor;
    }
    return self;
}

- (instancetype)initWithPresentedAnimator:(id<UIViewControllerAnimatedTransitioning>)presentedAnimator withDismissalAnimator:(id<UIViewControllerAnimatedTransitioning>)dismissalAnimator {
    return [self initWithPresentedAnimator:presentedAnimator
                     withDismissalAnimator:dismissalAnimator
                   withPresentedInteractor:nil
                   withDismissalInteractor:nil];
}

- (instancetype)initWithPresentedInteractor:(id<UIViewControllerInteractiveTransitioning>)presentedInteractor withDismissalInteractor:(id<UIViewControllerInteractiveTransitioning>)dismissalInteractor {
    return [self initWithPresentedAnimator:nil
                     withDismissalAnimator:nil
                   withPresentedInteractor:presentedInteractor
                   withDismissalInteractor:dismissalInteractor];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if (self.presentedAnimator) {
        return self.presentedAnimator;
    } else if (self.providePresentAnimatorBlock) {
        return self.providePresentAnimatorBlock(presented, presenting, source);
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if (self.dismissalAnimator) {
        return self.dismissalAnimator;
    } else if (self.provideDismissalAnimatorBlock) {
        return self.provideDismissalAnimatorBlock(dismissed, nil, nil);
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    if (self.presentedInteractor) {
        return self.presentedInteractor;
    } else if (self.providePresentInteractorBlock) {
        return self.providePresentInteractorBlock(animator);
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    if (self.dismissalInteractor) {
        return self.dismissalInteractor;
    } else if (self.provideDismissalInteractorBlock) {
        return self.provideDismissalInteractorBlock(animator);
    }
    return nil;
}

@end
