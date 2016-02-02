//
//  TransitionAnimator.h
//  BlurredPopover
//
//  Created by Mykola Denysyuk on 1/31/16.
//  Copyright © 2016 Mykola Denysyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIViewControllerTransitioning.h>

//--------------------------------------------------------------------
@class TransitionAnimator;
typedef void(^AnimateTransitionBlock)(TransitionAnimator *animator);
//--------------------------------------------------------------------

/**
 *  Base helper transition animator class.
 *  Provide access to transitioning controllers and views.
 *  Also, provides access to animated transitioning process via blocks.
 */
@interface TransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning> {
    @protected
    UIViewController * __weak _fromViewController;
    UIViewController * __weak _toViewController;
    UIView * __weak _fromView;
    UIView * __weak _toView;
    UIView * __weak _containerView;
    NSTimeInterval _transitionDuration;
}

// not-nil only when -animateTransition: is called
@property (readonly, nonatomic, weak) UIViewController * fromViewController;
@property (readonly, nonatomic, weak) UIViewController * toViewController;
@property (readonly, nonatomic, weak) UIView * fromView;
@property (readonly, nonatomic, weak) UIView * toView;
@property (readonly, nonatomic, weak) UIView * containerView;

// set block to specify transition animation
@property (copy, nonatomic) AnimateTransitionBlock transitionAnimationBlock;

// transition duration
@property (readonly, nonatomic) NSTimeInterval transitionDuration;

/** Use this initialiser to specify transition duration and animation block simultaneously,
  * otherwise, feel free to use simple -init and set animation block later */
- (instancetype)initWithTransitionDuration:(NSTimeInterval)duration animationBlock:(AnimateTransitionBlock)block;

/** set YES if this is animator for dismissal transition */
@property (assign, nonatomic, getter=isDismissal) BOOL dismissal;

@end
