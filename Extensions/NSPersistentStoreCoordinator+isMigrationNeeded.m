//
//  NSPersistentStoreCoordinator+isMigrationNeeded.m
//  
//
//  Created by Mykola Denysyuk on 9/1/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import "NSPersistentStoreCoordinator+isMigrationNeeded.h"

@implementation NSPersistentStoreCoordinator (isMigrationNeeded)

- (BOOL)isMigrationNeededForCoordinatorAtStoredUrl:(NSURL *)storeUrl
{
    NSError *error = nil;
    NSDictionary *sourceMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType
                                                                                              URL:storeUrl
                                                                                            error:&error];
    if(!error && sourceMetadata) {
        NSManagedObjectModel * destinationModel = [self managedObjectModel];
        BOOL isCompatibile = [destinationModel isConfiguration:nil compatibleWithStoreMetadata:sourceMetadata];
        return !isCompatibile;
    }
    return NO;
}

@end
