//
//  UIResponder+FirstResponer.h
//  Utils
//
//  Created by Mykola Denysyuk on 3/18/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//
//  Original idea by Jakob Egger
//  http://stackoverflow.com/a/14135456/2960612


#import <UIKit/UIKit.h>

@interface UIResponder (FirstResponer)

+ (id)currentFirstResponder;
- (id)currentFirstResponder;
- (UIView *)currentFirstResponderView;

@end
