//
//  UIView+ColoredNib.m
//  Utils
//
//  Created by Mykola Denysyuk on 12/10/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import "UIView+ColoredNib.h"

@implementation UIView (ColoredNib)

- (void)setBackgroundColorName:(NSString *)backgroundColorName
{
    SEL selector = NSSelectorFromString(backgroundColorName);
    if ([UIColor respondsToSelector:selector]) {
        self.backgroundColor = [UIColor performSelector:selector];
    }
}

- (NSString *)backgroundColorName
{
    return nil;
}

@end


@implementation UILabel (ColoredNib)

- (void)setTextColorName:(NSString *)textColorName
{
    SEL selector = NSSelectorFromString(textColorName);
    if ([UIColor respondsToSelector:selector]) {
        self.textColor = [UIColor performSelector:selector];
    }
}

- (NSString *)textColorName
{
    return nil;
}

@end

@implementation UIButton (ColoredNib)

- (void)setTextColorName:(NSString *)textColorName
{
    SEL selector = NSSelectorFromString(textColorName);
    if ([UIColor respondsToSelector:selector]) {
        [self setTitleColor:[UIColor performSelector:selector]
                   forState:UIControlStateNormal];
    }
}

- (NSString *)textColorName
{
    return nil;
}

@end

@implementation UITextField (ColoredNib)

- (void)setTextColorName:(NSString *)textColorName
{
    SEL selector = NSSelectorFromString(textColorName);
    if ([UIColor respondsToSelector:selector]) {
        self.textColor = [UIColor performSelector:selector];
    }
}

- (NSString *)textColorName
{
    return nil;
}

@end