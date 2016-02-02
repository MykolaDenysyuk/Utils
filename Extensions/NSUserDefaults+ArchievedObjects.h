//
//  NSUserDefaults+ArchievedObjects.h
//  Utils
//
//  Created by Mykola Denysyuk on 9/8/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (ArchievedObjects)

- (void)setAndArchieveObject:(id<NSCoding>)object forKey:(NSString *)key;
- (id<NSCoding>)unarchievedObjectForKey:(NSString *)key;

@end
