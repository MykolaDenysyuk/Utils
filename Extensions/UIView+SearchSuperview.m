//
//  UIView+SearchSuperview.m
//  LifeGuardClient
//
//  Created by Mykola Denysyuk on 8/7/14.
//  Copyright (c) 2014 stature. All rights reserved.
//

#import "UIView+SearchSuperview.h"

@implementation UIView (SearchSuperview)

// Performance heave

- (UIView *)superviewWithClassKind:(Class)superviewClass
{
    if ([self.superview isKindOfClass:superviewClass])
        return self.superview;
    else
        return [self.superview superviewWithClassKind:superviewClass];
    
}

- (UIView *)subviewWithClassKind:(Class)subviewClass
{
    for (UIView* subview  in self.subviews) {
        if ([subview isKindOfClass:subviewClass])
            return subview;
        else
        {
            UIView* view = [subview subviewWithClassKind:subviewClass];
            if (view) {
                return view;
            }
        }
    }
    return nil;
}


// Performance lite

- (UIView *)superviewWithClassMember:(Class)superviewClass
{
    if ([self.superview isMemberOfClass:superviewClass])
        return self.superview;
    else
        return [self.superview superviewWithClassMember:superviewClass];
}

- (UIView *)subviewWithClassMember:(Class)subviewClass
{
    for (UIView* subview  in self.subviews) {
        if ([subview isMemberOfClass:subviewClass])
            return subview;
        else
        {
            UIView* view = [subview subviewWithClassKind:subviewClass];
            if (view) {
                return view;
            }
        }
    }
    return nil;
}

@end
