//
//  NSArray+Order.m
//  Utils
//
//  Created by Mykola Denysyuk on 6/3/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//

#import "NSArray+Order.h"

@implementation NSArray (Order)

- (BOOL)isEqualOrdered:(NSArray *)referenceOrderedArray
{
    BOOL isOrderEqual = YES;
    // Map order items to make it possible to compare [item : order_position]
    
    NSMutableDictionary* orderMapping = [NSMutableDictionary dictionaryWithCapacity:referenceOrderedArray.count];
    [referenceOrderedArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [orderMapping setObject:@(idx)
                         forKey:[self p_keyForObject:obj]];
    }];
    
    // check if all items in self situated in required positions
    
    NSMutableArray * orderCheckList = self.mutableCopy;
    
    NSNumber * currentItem = nil;
    for (; orderCheckList.count>0 ;)
    {
        currentItem = orderCheckList.firstObject;
        if (currentItem)[orderCheckList removeObjectAtIndex:0];
        for (NSNumber* nextItem in orderCheckList)
        {
            NSNumber* currentOrder = orderMapping[[self p_keyForObject:currentItem]];
            NSNumber* nextOrder = orderMapping[[self p_keyForObject:nextItem]];
            if (currentOrder && nextOrder && [currentOrder compare:nextOrder] == NSOrderedDescending)
            {
                isOrderEqual = NO;
                break;
            }
        }
        if (isOrderEqual == NO)
            break;
    }
    return isOrderEqual;
}

- (NSString *)p_keyForObject:(id)object
{
    if ([object isKindOfClass:[NSString class]])
    {
        return object;
    }
    else if ([object isKindOfClass:[NSNumber class]])
    {
        return [object stringValue];
    }
    else return [NSString stringWithFormat:@"%zd", [object hash]];
    
}

@end
