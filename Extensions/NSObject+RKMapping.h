//
//  NSObject+RKMapping.h
//
//
//  Created by Mykola Denysyuk on 12/12/13.
// 
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface NSObject (RKMapping)

+ (NSDictionary *)mappingDictionary;
+ (NSArray *)propertyMappingRelations;
+ (void)setupMapping:(RKObjectMapping *)mapping;

+ (RKObjectMapping*)objectMapping;

@end
