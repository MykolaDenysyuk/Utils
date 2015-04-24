//
//  CustomPopoverController.m
//  MilleniumSpeakerKit
//
//  Created by Mykola Denysyuk on 1/19/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//

#import "CustomPopoverController.h"
#import "UIColor+CustomColors.h"

static float const kCornerRadius = 10;
static NSTimeInterval const kAnimationDuration = 0.15f;
static CGFloat const kBorderWidth = .5f;

@interface CustomPopoverController ()

@property (weak, nonatomic) IBOutlet UIView *contentHolderView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@property (nonatomic) BOOL isPresented;

@end

@implementation CustomPopoverController

#pragma mark - Lifecycle:

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSAssert(NO, @"use initWithContentController: to instantiate CustomPopoverController");
    return nil;
}

- (id)initWithContentController:(UIViewController *)contentController
{
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        [self view];
        [contentController view];
        _contentController = contentController;
        _contentHolderView.backgroundColor = [UIColor stdBlueColor];
        _contentHolderView.layer.masksToBounds = YES;
        _contentHolderView.layer.cornerRadius = kCornerRadius;
        
        _contentController.view.layer.cornerRadius = kCornerRadius;
        _contentController.view.layer.masksToBounds = YES;
        [_contentHolderView addSubview:_contentController.view];
        
        [self addChildViewController:_contentController];
    }
    return self;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect contentHolderFrame = _contentHolderView.frame;
    
    /* align content appropriate to popoverLayoutMargins */
    
    if (CGRectGetMidY(contentHolderFrame)<_popoverLayoutMargins.top) {
        contentHolderFrame.origin.y = _popoverLayoutMargins.top;
    }
    if (CGRectGetMinX(contentHolderFrame)<_popoverLayoutMargins.left) {
        contentHolderFrame.origin.x = _popoverLayoutMargins.left;
    }
    CGFloat needsHeight = CGRectGetHeight(self.view.frame)- _popoverLayoutMargins.top - _popoverLayoutMargins.bottom;
    if (CGRectGetHeight(contentHolderFrame) > needsHeight) {
        contentHolderFrame.size.height = needsHeight;
    }
    CGFloat needsWidth = CGRectGetWidth(self.view.frame) - _popoverLayoutMargins.left - _popoverLayoutMargins.right;
    if (CGRectGetWidth(contentHolderFrame) > needsWidth) {
        contentHolderFrame.size.width = needsWidth;
    }
    
    _contentHolderView.frame = contentHolderFrame;
    
    _contentController.view.frame = CGRectInset(_contentHolderView.bounds, 2*kBorderWidth, 2*kBorderWidth);
    
    /* align popover arrow */
    
    CGRect arrowRect = _arrowImageView.frame;
    arrowRect.origin.y = CGRectGetMinY(contentHolderFrame) - CGRectGetHeight(arrowRect);
    
    if (CGRectGetWidth(contentHolderFrame) > 123) {
        arrowRect.origin.x = CGRectGetMinX(contentHolderFrame) + 24;
    } else
        arrowRect.origin.x = CGRectGetMinX(contentHolderFrame) + (CGRectGetWidth(contentHolderFrame) - CGRectGetWidth(arrowRect))/2;
    
    _arrowImageView.frame = arrowRect;
}

- (BOOL)popoverVisible
{
    return _isPresented;
}

- (void)setPopoverLayoutMargins:(UIEdgeInsets)popoverLayoutMargins
{
    _popoverLayoutMargins = popoverLayoutMargins;
    [self.view setNeedsLayout];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    _contentHolderView.backgroundColor = borderColor;
}

- (void)presentFromRect:(CGRect)fromRect inView:(UIView *)inView
{
    if (self.isPresented) {
        return;
    }
    
    /* calculate postition */
    
    UIWindow * window = inView.window;
    UIView * rootView = window.rootViewController.presentedViewController ? window.rootViewController.presentedViewController.view : window.rootViewController.view;
    CGRect convertedRect = [rootView convertRect:fromRect fromView:inView];
    _contentHolderView.frame = CGRectMake(CGRectGetMinX(convertedRect), CGRectGetMaxY(convertedRect)+CGRectGetHeight(_arrowImageView.frame),
                                           _contentController.preferredContentSize.width + 2*kBorderWidth,
                                           _contentController.preferredContentSize.height + 2*kBorderWidth);
    
    /* perform animated presentation */
    
    self.view.alpha = 0;
    self.view.frame = window.rootViewController.view.bounds;
    [rootView addSubview:self.view];

    [self.view setNeedsLayout];
    
    typeof(self) __weak weakSelf = self;
    [UIView animateWithDuration:kAnimationDuration
                     animations:^{
                         weakSelf.view.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         weakSelf.isPresented = YES;
                     }];
}

#pragma mark - Actions:

- (IBAction)tapOutsideContentGesture:(UITapGestureRecognizer *)sender
{
    if (CGRectContainsPoint(_contentHolderView.frame, [sender locationInView:sender.view]) == NO) {
        [self dismissViewControllerAnimated:YES
                                 completion:nil];
    }
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    typeof(self) __weak weakSelf = self;
    [UIView animateWithDuration:kAnimationDuration
                     animations:^{
                         weakSelf.view.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [weakSelf.view removeFromSuperview];
                         weakSelf.isPresented = NO;
                         if (weakSelf.delegate) {
                             [weakSelf.delegate popoverDismissed:weakSelf];
                         }
                     }];
}

@end
