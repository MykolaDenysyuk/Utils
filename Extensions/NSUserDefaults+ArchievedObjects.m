//
//  NSUserDefaults+ArchievedObjects.m
//  Utils
//
//  Created by Mykola Denysyuk on 9/8/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//

#import "NSUserDefaults+ArchievedObjects.h"

@implementation NSUserDefaults (ArchievedObjects)

- (void)setAndArchieveObject:(id<NSCoding>)object forKey:(NSString *)key{
    // Write to NSUserDefaults
    NSData *archivedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:archivedObject forKey:key];
    [defaults synchronize];
}

- (id<NSCoding>)unarchievedObjectForKey:(NSString *)key{
    // Read from NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *archivedObject = [defaults objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:archivedObject];
}

@end
