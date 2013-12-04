//
//  NSString+Ordinal.m
//
//
//  Created by Mykola Denysyuk on 12/4/13.
//  
//

#import "NSString+Ordinal.h"

@implementation NSString (Ordinal)

- (NSString *)ordinalNumberString
{
    int number = self.integerValue;
    if (number > 10 && number < 20) {
        return [self caseAppropriateEnd:number];
    }
    else
        return [self caseAppropriateEnd:number%10];
}

+ (NSString *)stringWithOrdinalInt:(int)number
{
    NSString* numberString = [NSString stringWithFormat:@"%i", number];
    return [numberString ordinalNumberString];
}

#pragma mark - Private helpers:

- (NSString *)caseAppropriateEnd:(int)integerValue
{
    switch (integerValue) {
    case 1:
        return [self stringByAppendingString:@"st"];
        break;
        
    case 2:
        return [self stringByAppendingString:@"nd"];
        break;
        
    case 3:
        return [self stringByAppendingString:@"rd"];
        break;
        
    default:
        return [self stringByAppendingString:@"th"];
        break;
    }
}



@end
