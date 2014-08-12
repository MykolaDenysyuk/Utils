//
//  UIView+onDrawRectBlock.h
//  LayerTest
//
//  Created by Mykola Denysyuk on 8/4/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DrawRectBlock)(CGContextRef context, CGRect rect);

@interface UIView (onDrawRectBlock)

@property (nonatomic, copy) DrawRectBlock drawRectBlock;

@end