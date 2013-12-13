//
//  NSManagedObject+RKMapping.m
//
//
//  Created by Mykola Denysyuk on 12/12/13.
//  
//

#import "NSManagedObject+RKMapping.h"
#import <RestKit/RestKit.h>

@implementation NSManagedObject (RKMapping)

+ (NSArray *)identifiers
{
    return nil;
}

+ (RKObjectMapping *)objectMappingForManagedObjectStore:(RKManagedObjectStore *)store
{
    RKEntityMapping* mapping = [RKEntityMapping mappingForEntityForName:NSStringFromClass(self.class)
                                                   inManagedObjectStore:store];
    [self setupMapping:mapping];
    [mapping setIdentificationAttributes:[self identifiers]];
    
    return mapping;
}

@end
