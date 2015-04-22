//
//  UIView+AddResizableSubview.m
//
//
//  Created by Mykola Denysyuk on 3/23/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//

#import "UIView+AddResizableSubview.h"

@implementation UIView (AddResizableSubview)

- (void)addResizableSubview:(UIView *)view
{
    view.frame = self.bounds;
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self addSubview:view];
}

@end
