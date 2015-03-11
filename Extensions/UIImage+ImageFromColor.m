//
//  UIImage+ImageFromColor.m
//  Utils
//
//  Created by Mykola Denysyuk on 2/5/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//

#import "UIImage+ImageFromColor.h"

@implementation UIImage (ImageFromColor)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
