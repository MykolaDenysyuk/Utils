//
//  NSString+Compare.m
//  
//
//  Created by Mykola Denysyuk on 11/20/13.
//  
//

#import "NSString+Compare.h"

@implementation NSString (Compare)

- (BOOL)isContainString:(NSString *)substring
{
    return [self rangeOfString:substring].location != NSNotFound;
}

- (BOOL)isStringIn:(NSArray *)strings
{
    for (NSString* string in strings) {
        if ([self isEqualToString:string]) return YES;
    }
    return NO;
}

@end
