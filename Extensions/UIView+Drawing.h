//
//  UIView+Drawing.h
//
//
//  Created by Mykola Denysyuk on 6/28/14.
//
//

#import <UIKit/UIKit.h>

//
// Methods:

@interface UIView (Drawing)

@end

//
// Functions:

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor);