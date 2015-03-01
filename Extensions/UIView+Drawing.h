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

static inline double radians (double degrees) { return degrees * M_PI/180; }

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor);

CGRect rectFor1PxStroke(CGRect rect);

void draw1PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color);

void drawGlossAndGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor);

CGMutablePathRef createArcPathFromBottomOfRect(CGRect rect, CGFloat arcHeight);

CGMutablePathRef createRoundedRectForRect(CGRect rect, CGFloat radius);
