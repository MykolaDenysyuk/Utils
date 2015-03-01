//
//  ViewAnimator.h
//  Utils
//
//  Created by Mykola Denysyuk on 1/13/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIView;

@interface ViewAnimator : NSObject

@property (readonly, nonatomic, weak) UIView * view;
@property (readonly, nonatomic, getter=isAnimating) BOOL animating;

- (id)initWithView:(UIView *)view;

- (void)startAnimating;
- (void)stopAnimating;

@end
