//
//  NSString+Compare.h
//  
//
//  Created by Mykola Denysyuk on 11/20/13.
//  
//

#import <Foundation/Foundation.h>

@interface NSString (Compare)

- (BOOL)isContainString:(NSString *)substring;
- (BOOL)isStringIn:(NSArray *)strings;

@end
