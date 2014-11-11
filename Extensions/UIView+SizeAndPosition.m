//
//  UIView+SizeAndPosition.m
//  UIView+SizeAndPosition
//
//  Created by Mykola Denysyuk on 10/29/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import "UIView+SizeAndPosition.h"

@implementation UIView (SizeAndPosition)

#pragma mark - Setters:

- (void)setOrigin:(CGPoint)origin
{
    [self setFrame:CGRectMake(origin.x, origin.y,
                              CGRectGetWidth(self.frame),
                              CGRectGetHeight(self.frame))];
}

- (void)setXOrigin:(CGFloat)xOrigin
{
    [self setOrigin:CGPointMake(xOrigin, self.yOrigin)];
}

- (void)setYOrigin:(CGFloat)yOrigin
{
    [self setOrigin:CGPointMake(self.xOrigin, yOrigin)];
}

- (void)setSize:(CGSize)size
{
    [self setFrame:CGRectMake(self.origin.x, self.origin.y,
                              size.width, size.height)];
}

- (void)setWidth:(CGFloat)width
{
    [self setSize:CGSizeMake(width, self.height)];
}

- (void)setHeight:(CGFloat)height
{
    [self setSize:CGSizeMake(self.width, height)];
}

- (void)setXCenter:(CGFloat)xCenter
{
    [self setCenter:CGPointMake(xCenter, self.yCenter)];
}

- (void)setYCenter:(CGFloat)yCenter
{
    [self setCenter:CGPointMake(self.xCenter, yCenter)];
}

#pragma mark - Getters:

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)xOrigin
{
    return self.origin.x;
}

- (CGFloat)yOrigin
{
    return self.origin.y;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)width
{
    return self.size.width;
}

- (CGFloat)height
{
    return self.size.height;
}

- (CGFloat)xCenter
{
    return self.center.x;
}

- (CGFloat)yCenter
{
    return self.center.y;
}

@end
