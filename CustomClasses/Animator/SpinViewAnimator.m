//
//  SpinViewAnimator.m
//  Utils
//
//  Created by Mykola Denysyuk on 1/13/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//

#import "SpinViewAnimator.h"
#import <UIKit/UIView.h>

@implementation SpinViewAnimator

BOOL animating;

- (void)startAnimating
{
    if (!self.isAnimating) {
        [super startAnimating];
        [self spinWithOptions: UIViewAnimationOptionCurveEaseIn];
    }
}

- (void)spinWithOptions: (UIViewAnimationOptions) options {
    // this spin completes 360 degrees every second
    typeof(self) __weak weakSelf = self;
    [UIView animateWithDuration: 0.25f
                          delay: 0.0f
                        options: options
                     animations: ^{
                         weakSelf.view.transform = CGAffineTransformRotate(weakSelf.view.transform, M_PI_2);
                     }
                     completion: ^(BOOL finished) {
                         if (finished) {
                             if (weakSelf.isAnimating) {
                                 // if flag still set, keep spinning with constant speed
                                 [weakSelf spinWithOptions: UIViewAnimationOptionCurveLinear];
                             } else if (options != UIViewAnimationOptionCurveEaseOut) {
                                 // one last spin, with deceleration
                                 [weakSelf spinWithOptions: UIViewAnimationOptionCurveEaseOut];
                             }
                         }
                     }];
}

@end
