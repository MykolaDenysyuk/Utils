//
//  XPhoneFormatter.m
//  Utils
//
//  Created by Mykola Denysyuk on 6/18/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//

#import "XPhoneFormatter.h"

NSString * const XPhoneFormatterDefaultFormat = @"(###) ###-####";
NSString * const XPhoneFormatterMaskSymbol = @"#";

@implementation XPhoneFormatter

- (instancetype)init
{
    if (self=[super init])
    {
        _format = XPhoneFormatterDefaultFormat;
    }
    return self;
}

- (NSString *)stringForObjectValue:(id)obj
{
    if ([obj isKindOfClass:[NSString class]] == NO || _format.length == 0)
        return nil;
    
    NSString* formattingString = [obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (formattingString.length == 0)
        return nil;
    
    __block NSString * resultString = @"";
    __block NSInteger nextSymbolIndex = 0;

    [_format enumerateSubstringsInRange:NSMakeRange(0, _format.length)
                                options:NSStringEnumerationByComposedCharacterSequences
                             usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                 if ([substring isEqualToString:XPhoneFormatterMaskSymbol])
                                 {
                                     substring = [formattingString substringWithRange:NSMakeRange(nextSymbolIndex, substringRange.length)];
                                     nextSymbolIndex++;
                                 }
                                 
                                 resultString = [resultString stringByAppendingString:substring];
                                 if (nextSymbolIndex >= formattingString.length)
                                     *stop = YES;
                             }];
    return resultString;
}

@end
