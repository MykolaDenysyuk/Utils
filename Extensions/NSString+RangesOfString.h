//
//  NSString+RangesOfString.h
//
//
//  Created by Mykola Denysyuk on 4/2/14.
//  Inspired by Chris Johnsen's idea
//

#import <Foundation/Foundation.h>

@interface NSString (RangesOfString)

// Returns array of substring occurance ranges wrapped into NSValue

- (NSArray *)rangesOfString:(NSString *)string;

@end
