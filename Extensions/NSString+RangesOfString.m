//
//  NSString+RangesOfString.m
//
//
//  Created by Mykola Denysyuk on 4/2/14.
//  
//

#import "NSString+RangesOfString.h"

@implementation NSString (RangesOfString)

- (NSArray *)rangesOfString:(NSString *)string
{
    NSMutableArray * ranges = [NSMutableArray new];
    NSUInteger selfLength = [self length];
    NSRange uncheckedRange = NSMakeRange(0, selfLength);
    for(;;) {
        NSRange range = [self rangeOfString:string
                                    options:0
                                      range:uncheckedRange];
        if (range.location == NSNotFound)
            return ranges;
        
        // Else:
        
        [ranges addObject:[NSValue valueWithRange:range]];
        NSUInteger nextLocation = NSMaxRange(range);
        uncheckedRange = NSMakeRange(nextLocation, selfLength - nextLocation);
    }
}

@end
