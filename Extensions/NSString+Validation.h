//
//  NSString+Validation.h
//  
//
//  Created by Mykola Denysyuk on 7/18/13.
//  Copyright (c) 2013 Mykola Denysyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validation)

- (BOOL)validateEmail;

- (BOOL)validatePhone;

- (BOOL)validateZipCode;

@end
