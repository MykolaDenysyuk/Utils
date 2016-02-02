//
//  UIViewController+DebugLog.m
//  Utils
//
//  Created by Mykola Denysyuk on 12/15/15.
//  Copyright © 2015 Mykola Denysyuk. All rights reserved.
//

#import "UIViewController+DebugLog.h"
#import <objc/runtime.h>

@implementation UIViewController (DebugLog)

+ (void)load {
    Method method = class_getInstanceMethod(self, @selector(viewDidAppear:));
    Method swizzedMethod = class_getInstanceMethod(self, @selector(swizzed_viewDidAppear:));
    method_exchangeImplementations(method,
                                   swizzedMethod);
}

- (void)swizzed_viewDidAppear:(BOOL)animated {
    [self swizzed_viewDidAppear:animated];
    printf("\n%s\n%s\n", __FUNCTION__, [self.class.debugDescription cStringUsingEncoding:NSUTF8StringEncoding]);
}

@end
