//
//  UIColor+RandomColor.h
//  
//
//  Created by Tayphoon on 23.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor(Extensions)

+ (UIColor*)randomColor;

+ (UIColor*)colorWithHexInt:(int) hexColor; //converts color from hex int to UIColor

+ (UIColor*)colorWithHexInt:(int) hexColor alpha:(CGFloat) alpha; //converts color from hex int to UIColor

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue; //converts RGB to UIColor

+ (UIColor *)colorWithHexString:(NSString *)hexString;//converts color from hex string to UIColor

@end
