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

- (void)applyBackgroundGradientWithColors:(NSArray *)colors whichBeginsAt:(CGPoint)startAt andEndsAt:(CGPoint)endAt;

@end

//
// Functions:

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor);