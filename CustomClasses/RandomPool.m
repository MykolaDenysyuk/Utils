//
//  RandomPool.m
//
//
//  Created by Mykola Denysyuk on 7/24/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import "RandomPool.h"

@interface RandomPool ()

@property (nonatomic, strong) NSMutableArray * objectsLeft;

@end

@implementation RandomPool

- (id)initWithObjectsCollection:(id<NSFastEnumeration>)collection
{
    self = [self init];
    if (self) {
        [self setObjectCollection:collection];
    }
    return self;
}

- (void)setObjectCollection:(id<NSFastEnumeration>)collection
{
    if ([(id)collection respondsToSelector:@selector(countByEnumeratingWithState:objects:count:)]) {
        NSMutableArray * mAllObjects = [NSMutableArray new];
        for (id item in collection)
            [mAllObjects addObject:item];
        
        _allObjects = mAllObjects.copy;
        self.objectsLeft? [self.objectsLeft removeAllObjects] : nil;
        self.objectsLeft = [NSMutableArray arrayWithArray:_allObjects];
    }
    else
        NSAssert(NO, @"collection [%@] is not supported or nil. Collection should be NSArray, NSSet or NSDictionary instance", collection);
}

- (id)randomObject
{
    if (self.objectsLeft.count == 0) {
        [self.objectsLeft addObjectsFromArray:self.allObjects];
    }
    
    int randomIndex = arc4random()%self.objectsLeft.count;
    id randomObject = [self.objectsLeft objectAtIndex:randomIndex];
    [self.objectsLeft removeObject:randomObject];
    
    return randomObject;
}

@end