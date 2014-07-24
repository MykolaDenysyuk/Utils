//
//  RandomPool.h
//
//
//  Created by Mykola Denysyuk on 7/24/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RandomPool : NSObject

@property (readonly, strong) NSArray * allObjects;

- (id)initWithObjectsCollection:(id<NSFastEnumeration>)collection;
- (void)setObjectCollection:(id<NSFastEnumeration>)collection;

- (id)randomObject;

@end
