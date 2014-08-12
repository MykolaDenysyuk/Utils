//
//  UIView+onDrawRectBlock.m
//  LayerTest
//
//  Created by Mykola Denysyuk on 8/4/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import "UIView+onDrawRectBlock.h"
#import <objc/runtime.h>

#define kDrawBlockKey @"drawBlock"

@implementation UIView (onDrawRectBlock)

- (void)setDrawRectBlock:(DrawRectBlock)drawRectBlock
{
    objc_setAssociatedObject(self, kDrawBlockKey, drawRectBlock, OBJC_ASSOCIATION_COPY);
}

- (DrawRectBlock)drawRectBlock
{
    DrawRectBlock block = objc_getAssociatedObject(self, kDrawBlockKey);
    return block;
}

- (void)drawRect:(CGRect)rect
{
    if (self.drawRectBlock) {
        self.drawRectBlock(UIGraphicsGetCurrentContext(), rect);
    }
}

@end
