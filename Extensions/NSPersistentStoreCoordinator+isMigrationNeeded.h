//
//  NSPersistentStoreCoordinator+isMigrationNeeded.h
//  
//
//  Created by Mykola Denysyuk on 9/1/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSPersistentStoreCoordinator (isMigrationNeeded)

- (BOOL)isMigrationNeededForCoordinatorAtStoredUrl:(NSURL*)storeUrl;

@end