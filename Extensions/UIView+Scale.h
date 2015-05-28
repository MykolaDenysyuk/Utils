//
//  UIView+Scale.h
//  Utils
//
//  Created by Mykola Denysyuk on 5/25/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

// TODO: make single method with UIViewContentMode option

@interface UIView (Scale)

+ (CGRect)scaleRect:(CGRect)rect toFitBounds:(CGRect)bounds;

@end
