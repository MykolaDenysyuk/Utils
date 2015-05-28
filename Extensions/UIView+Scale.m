//
//  UIView+Scale.m
//  Utils
//
//  Created by Mykola Denysyuk on 5/25/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//

#import "UIView+Scale.h"

@implementation UIView (Scale)

+ (CGRect)scaleRect:(CGRect)rect toFitBounds:(CGRect)bounds
{
    CGFloat const kAspectRatio = CGRectGetWidth(rect) / CGRectGetHeight(rect);
    
    CGRect scaledRect;
    if (CGRectGetHeight(bounds)*kAspectRatio > CGRectGetWidth(bounds))
        scaledRect.size = CGSizeMake(CGRectGetWidth(bounds), CGRectGetWidth(bounds)/kAspectRatio);
    else if (CGRectGetWidth(bounds)/kAspectRatio > CGRectGetHeight(bounds))
        scaledRect.size = CGSizeMake(CGRectGetHeight(bounds)*kAspectRatio, CGRectGetHeight(bounds));
    else
        scaledRect.size = bounds.size;
    scaledRect.origin = CGPointMake((CGRectGetWidth(bounds) - CGRectGetWidth(scaledRect))/2,
                                    (CGRectGetHeight(bounds) - CGRectGetHeight(scaledRect))/2);
    
    return scaledRect;
}

@end
