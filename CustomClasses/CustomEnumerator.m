//
//  CustomEnumerator.m
//  
//
//  Created by Mykola Denysyuk on 11/20/13.
//  
//

#import "CustomEnumerator.h"

@implementation CustomEnumerator
{
    NSArray* _list;
}

- (id)initWithCollection:(id)collection
{
    self = [super init];
    if (self) {
        if ([collection isKindOfClass:[NSArray class]]) {
            _list = collection;
        } else
            if ([collection isKindOfClass:[NSDictionary class]]) {
                _list = [collection allValues];
            } else
                if ([collection isKindOfClass:[NSSet class]]) {
                    _list = [collection allObjects];
                } else
                    if ([collection isKindOfClass:[NSOrderedSet class]]) {
                        _list = [collection array];
                    }
        else
            NSAssert(YES, @"CustomEnumerator could not enumerate objects from <%@> collection", [collection class]);
        
        _currentIndex = -1;
        
    }
    
    return self;
}

- (id)itemAtIndex:(int)index
{
    if (_cycled) {
        if (index < 0) {
            _currentIndex = _list.count-1;
        }
        else if (index > _list.count)
        {
            _currentIndex = 0;
        }
    }
    if (_currentIndex > 0 && _currentIndex < _list.count) {
        return _list[_currentIndex];
    }
    else return nil;
}

- (id)nextItem
{
    return [self itemAtIndex:++_currentIndex];
}

- (id)previousItem
{
    return [self itemAtIndex:--_currentIndex];
}

@end
