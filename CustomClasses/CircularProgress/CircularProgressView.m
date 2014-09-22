//
//  CircularProgressView.m
//  CircularProgress
//
//  Created by Mykola Denysyuk on 9/22/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import "CircularProgressView.h"

@implementation CircularProgressView

#pragma mark - Lifecycle:

- (void)initialize
{
    self.backgroundColor = [UIColor clearColor];
    _progressLineWidth = 10.f;
    _filledTrackColor = [UIColor whiteColor];
    _emptyTrackColor = [UIColor blackColor];
    _progress = 0.5f;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

#pragma mark - Accessors:

- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    _contentInsets = contentInsets;
    [self setNeedsDisplay];
}

- (void)setProgressLineWidth:(CGFloat)progressLineWidth
{
    _progressLineWidth = progressLineWidth;
    [self setNeedsDisplay];
}

- (void)setFilledTrackColor:(UIColor *)filledTrackColor
{
    _filledTrackColor = filledTrackColor;
    [self setNeedsDisplay];
}

- (void)setEmptyTrackColor:(UIColor *)emptyTrackColor
{
    _emptyTrackColor = emptyTrackColor;
    [self setNeedsDisplay];
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];
    NSLog(@"progress: %f", progress);
}

#pragma mark - Drawing:

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //
    // Make base - circle filled with emptyTrackColor(1),
    // calculate outter and inner circles(2) and clip inner hole(3):
    
    CGFloat side = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    CGRect squareBounds = CGRectMake(0, 0, side, side);
    CGRect outterCircle = CGRectOffset(squareBounds, self.contentInsets.left, self.contentInsets.top);   // (2)
    CGRect innerCircle = CGRectInset(outterCircle, self.progressLineWidth, self.progressLineWidth);     //
    
    CGContextAddEllipseInRect(context, outterCircle);   //
    CGContextAddEllipseInRect(context, innerCircle);    // - (3)
    CGContextEOClip(context);                           //
    
    CGContextSetFillColorWithColor(context, self.emptyTrackColor.CGColor);  //
    CGContextAddRect(context, outterCircle);                                // - (1)
    CGContextFillPath(context);                                             //
    
    
    //
    // Draw progress track filled with filledTrackColor:
    
    CGPoint center = CGPointMake(CGRectGetMidX(outterCircle), CGRectGetMidY(outterCircle));
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextAddArc(context, center.x, center.y, outterCircle.size.height/2, -M_PI_2, 2*M_PI*self.progress -M_PI_2, 0);
    CGContextClosePath(context);
    
    CGContextSetFillColorWithColor(context, self.filledTrackColor.CGColor);
    CGContextFillPath(context);
}

@end
