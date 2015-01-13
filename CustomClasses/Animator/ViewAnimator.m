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
}
@end

@implementation ViewAnimator

- (id)initWithView:(UIView *)view
{
    if (self = [super init]) {
        _view = view;
    }
    return self;
}

- (void)startAnimating
{
    _animating = YES;
}

- (void)stopAnimating
{
    _animating = NO;
}

@end
