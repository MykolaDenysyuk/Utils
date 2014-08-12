//
//  UIView+SearchSuperview.h
//  LifeGuardClient
//
//  Created by Mykola Denysyuk on 8/7/14.
//  Copyright (c) 2014 stature. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SearchSuperview)

/**
 return view of 'superviewClass' or its subclass. NOTE! in deep superviews stack will cause performance hit.
 */
- (UIView *)superviewWithClassKind:(Class)superviewClass;
- (UIView *)subviewWithClassKind:(Class)subviewClass;

/**
 return view of 'superviewClass'.
 */
- (UIView *)superviewWithClassMember:(Class)superviewClass;
- (UIView *)subviewWithClassMember:(Class)subviewClass;


@end
