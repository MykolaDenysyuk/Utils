//
//  NSString+Ordinal.h
//
//
//  Created by Mykola Denysyuk on 12/4/13.
//  
//

#import <Foundation/Foundation.h>

@interface NSString (Ordinal)

+ (NSString *)stringWithOrdinalInt:(int)number;

- (NSString *)ordinalNumberString;

@end
