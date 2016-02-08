//
//  AnimatedTransitionProvider.h
//  BlurredPopover
//
//  Created by Mykola Denysyuk on 1/31/16.
//  Copyright © 2016 Mykola Denysyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIViewControllerTransitioning.h>

/* Blocks definition */
//--------------------------------------------------------------------
typedef id<UIViewControllerAnimatedTransitioning>(^ProvideAnimatorBlock)(UIViewController *presented, UIViewController *presenting, UIViewController *source);
typedef id<UIViewControllerInteractiveTransitioning>(^ProvideInteractorBlock)(id<UIViewControllerAnimatedTransitioning> animator);
//--------------------------------------------------------------------


/**
 *  Provides custom animated transitioning and interaction for view controllers.
 *  @discusion Set animator or animator with interactor via intialiser OR use appropriate property blocks.
 */
@interface AnimatedTransitionProvider : NSObject <UIViewControllerTransitioningDelegate>

/** animation for controller to be presented */
@property (readonly, nonatomic) id<UIViewControllerAnimatedTransitioning> presentedAnimator;
/** animation for controller to be dismissed */
@property (readonly, nonatomic) id<UIViewControllerAnimatedTransitioning> dismissalAnimator;

- (instancetype)initWithPresentedAnimator:(id<UIViewControllerAnimatedTransitioning>)presentedAnimator
                    withDismissalAnimator:(id<UIViewControllerAnimatedTransitioning>)dismissalAnimator;

/** transition interacion for controller to be presented */
@property (readonly, nonatomic) id<UIViewControllerInteractiveTransitioning> presentedInteractor;
/** transition interacion for controller to be dismissed */
@property (readonly, nonatomic) id<UIViewControllerInteractiveTransitioning> dismissalInteractor;

- (instancetype)initWithPresentedInteractor:(id<UIViewControllerInteractiveTransitioning>)presentedInteractor
                    withDismissalInteractor:(id<UIViewControllerInteractiveTransitioning>)dismissalInteractor;

//--------------------------------------------------------------------
/** combined initializer */
- (instancetype)initWithPresentedAnimator:(id<UIViewControllerAnimatedTransitioning>)presentedAnimator
                    withDismissalAnimator:(id<UIViewControllerAnimatedTransitioning>)dismissalAnimator
                  withPresentedInteractor:(id<UIViewControllerInteractiveTransitioning>)presentedInteractor
                  withDismissalInteractor:(id<UIViewControllerInteractiveTransitioning>)dismissalInteractor;

@property (copy, nonatomic) ProvideAnimatorBlock providePresentAnimatorBlock;
- (void)setProvidePresentAnimatorBlock:(ProvideAnimatorBlock)providePresentAnimatorBlock;
/** where presented is dismissed controller */
@property (copy, nonatomic) ProvideAnimatorBlock provideDismissalAnimatorBlock;
- (void)setProvideDismissalAnimatorBlock:(ProvideAnimatorBlock)provideDismissalAnimatorBlock;
@property (copy, nonatomic) ProvideInteractorBlock providePresentInteractorBlock;
- (void)setProvidePresentInteractorBlock:(ProvideInteractorBlock)providePresentInteractorBlock;
@property (copy, nonatomic) ProvideInteractorBlock provideDismissalInteractorBlock;
- (void)setProvideDismissalInteractorBlock:(ProvideInteractorBlock)provideDismissalInteractorBlock;

@end
