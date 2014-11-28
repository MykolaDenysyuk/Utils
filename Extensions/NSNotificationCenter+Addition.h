//
//  NSNotificationCenter+Addition.h
//  Utils
//
//  Created by Mykola Denysyuk on 11/28/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (Addition)

- (void)removeObserver:(id)observer names:(NSArray *)names;
- (void)removeObserver:(id)observer namesAndObjects:(NSDictionary *)namesAndObjects;

@end
