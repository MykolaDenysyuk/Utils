//
//  UIColor+RandomColor.m
//  
//
//  Created by Tayphoon on 23.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
#import "UIColor+Extensions.h"

@implementation UIColor(Extensions)

+ (UIColor *) randomColor  {
    // GOAL: reject colors that are too dark
    float total = 3;
    float one = arc4random() % 256 / 256.0;
    total -= one;
    float two = arc4random() % 256 / 256.0;
    total -= two;
    float three = total; // UIColor will chop out-of-range nums
    
    NSMutableArray *threeFloats = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithFloat:one], [NSNumber numberWithFloat:two], [NSNumber numberWithFloat:three], nil];
    
    NSNumber *red, *green, *blue;
    red = [threeFloats objectAtIndex:arc4random() % [threeFloats count]];
    [threeFloats removeObject:red];
    green = [threeFloats objectAtIndex:arc4random() % [threeFloats count]];
    [threeFloats removeObject:green];
    blue = [threeFloats lastObject];
    
    return [UIColor colorWithRed:[red floatValue] green:[green floatValue] blue:[blue floatValue] alpha:1];
}

+ (UIColor*) colorWithHexInt:(int)hexColor {
    return [UIColor colorWithHexInt:hexColor alpha:1.0];
}

+ (UIColor*)colorWithHexInt:(int) hexColor alpha:(CGFloat) alpha
{
    return [UIColor colorWithRed:((float)((hexColor & 0xFF0000) >> 16))/255.0
                           green:((float)((hexColor & 0xFF00) >> 8))/255.0
                            blue:((float)(hexColor & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:r green:g blue:b];
}

@end
