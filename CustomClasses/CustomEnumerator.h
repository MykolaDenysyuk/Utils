//
//  CustomEnumerator.h
//  
//
//  Created by Mykola Denysyuk on 11/20/13.
//  
//

#import <Foundation/Foundation.h>

@interface CustomEnumerator : NSObject

@property BOOL cycled;
@property (readonly) int currentIndex;

- (id)initWithCollection:(id)collection;

- (id)nextItem;
- (id)previousItem;

@end
