//
//  UIViewController+AddContainerController.m
//
//
//  Created by Mykola Denysyuk on 3/24/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//

#import "UIViewController+AddContainerController.h"
#import "UIView+AddResizableSubview.h"

@implementation UIViewController (AddContainerController)

- (void)addChildContainerController:(UIViewController *)childController
{
    if (childController) {
        [childController willMoveToParentViewController:self];
        [self addChildViewController:childController];
        [self.view addResizableSubview:childController.view];
    }
}

- (void)addChildContainerController:(UIViewController *)childController insideSubview:(UIView *)subview {
    if (childController) {
        [childController willMoveToParentViewController:self];
        [self addChildViewController:childController];
        [subview addResizableSubview:childController.view];
    }
}

@end
