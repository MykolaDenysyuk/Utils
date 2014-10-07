//
//  NSString+Validation.m
//  
//
//  Created by Mykola Denysyuk on 7/18/13.
//  Copyright (c) 2013 Mykola Denysyuk. All rights reserved.
//

#define EMAIL_REGEX @"\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*"
#define PHONE_REGEX @"^\\(?([0-9]{3})\\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$"
#define ZIPCODE_REGEX @"^\\d{5}(?:[-\\s]\\d{4})?$"


#import "NSString+Validation.h"

@implementation NSString (Validation)

- (BOOL)validateEmail
{
    return [self validateWithRegEx:EMAIL_REGEX];
}

- (BOOL)validatePhone
{
    return [self validateWithRegEx:PHONE_REGEX];
}

- (BOOL)validateZipCode
{
    return [self validateWithRegEx:ZIPCODE_REGEX];
}

#pragma mark - private

- (BOOL)validateWithRegEx:(NSString*)regex
{
    NSPredicate *regexPred = [NSPredicate predicateWithFormat: @"self matches[cd] %@", regex];
    BOOL match = [regexPred evaluateWithObject: self];
    
    return match;
}

@end
