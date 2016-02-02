//
//  NSArray+Order.h
//  Utils
//
//  Created by Mykola Denysyuk on 6/3/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Order)

/** Checks if items in left array ordered in same way as in right array independently of size of both arrays.
    */
- (BOOL)isEqualOrdered:(NSArray *)referenceOrderedArray;

@end
