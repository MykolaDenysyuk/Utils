//
//  ViewAnimator.m
//  Utils
//
//  Created by Mykola Denysyuk on 1/13/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//

#import "ViewAnimator.h"
#import <UIKit/UIView.h>
#import <UIKit/UINibLoading.h>

@interface ViewAnimator ()
{
    __weak IBOutlet UIView *_view;
    BOOL _wasAnimating;
}
@end

@implementation ViewAnimator

#pragma mark - Lifecycle:

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithView:(UIView *)view
{
    if (self = [super init]) {
        _view = view;
        [self p_setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self p_setup];
}

- (void)p_setup
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(p_didBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(p_willResignActiveStatus:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
}

#pragma mark - Actions:

- (void)startAnimating
{
    _animating = YES;
}

- (void)stopAnimating
{
    _animating = NO;
}

#pragma mark - Private:

- (void)p_didBecomeActive:(NSNotification *)notification
{
    if (_wasAnimating)
        [self startAnimating];
}

- (void)p_willResignActiveStatus:(NSNotification *)notification
{
    _wasAnimating = _animating;
    if (_wasAnimating)
        [self stopAnimating];
}

@end
