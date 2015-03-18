//
//  UIResponder+FirstResponer.m
//  Utils
//
//  Created by Mykola Denysyuk on 3/18/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//
//
//  Original idea by Jakob Egger
//  http://stackoverflow.com/a/14135456/2960612


#import "UIResponder+FirstResponer.h"

static __weak id currentFirstResponder;

@implementation UIResponder (FirstResponer)

+(id)currentFirstResponder {
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}

- (id)currentFirstResponder
{
    return [self.class currentFirstResponder];
}

- (UIView *)currentFirstResponderView
{
    id firstResponer = [self currentFirstResponder];
    return [firstResponer isKindOfClass:[UIView class]] ? firstResponer : nil;
}

-(void)findFirstResponder:(id)sender {
    currentFirstResponder = self;
}

@end