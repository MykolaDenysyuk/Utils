//
//  UIView+Snapshot.m
//  
//
//  Created by Mykola Denysyuk on 3/12/14.
//
//

#import "UIView+Snapshot.h"

@implementation UIView (Snapshot)

- (UIImage *)makeSnapshot
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *copied = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copied;
}

@end
