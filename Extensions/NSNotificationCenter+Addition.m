//
//  NSNotificationCenter+Addition.m
//  Utils
//
//  Created by Mykola Denysyuk on 11/28/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import "NSNotificationCenter+Addition.h"

@implementation NSNotificationCenter (Addition)

- (void)removeObserver:(id)observer names:(NSArray *)names
{
    for (NSString* name in names) {
        [self removeObserver:observer
                        name:name
                      object:nil];
    }
}

- (void)removeObserver:(id)observer namesAndObjects:(NSDictionary *)namesAndObjects
{
    [namesAndObjects enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [self removeObserver:self
                        name:key
                      object:obj];
    }];
}

@end
