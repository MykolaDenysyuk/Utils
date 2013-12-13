//
//  NSObject+RKMapping.m
//
//
//  Created by Mykola Denysyuk on 12/12/13.
//  
//

#import "NSObject+RKMapping.h"
#import <RestKit/RestKit.h>

@implementation NSObject (RKMapping)

+ (NSDictionary *)mappingDictionary
{
    return nil;
}

+ (NSArray *)propertyMappingRelations
{
    return nil;
}

+ (RKObjectMapping *)objectMapping
{
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:self.class];
    [self setupMapping:mapping];
    
    return mapping;
}

+ (void)setupMapping:(RKObjectMapping *)mapping
{
    [mapping addAttributeMappingsFromDictionary:[self mappingDictionary]];
    
    for (RKRelationshipMapping* relation in [self propertyMappingRelations])
    {
        [mapping addPropertyMapping:relation];
    }
}

@end
