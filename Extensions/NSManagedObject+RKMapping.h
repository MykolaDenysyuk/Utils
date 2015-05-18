//
//  NSManagedObject+RKMapping.h
//
//
//  Created by Mykola Denysyuk on 12/12/13.
//  
//

#import <CoreData/CoreData.h>
#import "NSObject+RKMapping.h"

@class RKManagedObjectStore;

@interface NSManagedObject (RKMapping)

+ (NSArray *)identifiers;

+ (RKObjectMapping*)objectMappingForManagedObjectStore:(RKManagedObjectStore*)store;

+ (NSString *)entityName;

@end