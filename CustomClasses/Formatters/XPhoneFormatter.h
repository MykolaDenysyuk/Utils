//
//  XPhoneFormatter.h
//  Utils
//
//  Created by Mykola Denysyuk on 6/18/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const XPhoneFormatterDefaultFormat;
extern NSString * const XPhoneFormatterMaskSymbol;

/** Changes string phone presentation according to pre-set format */
@interface XPhoneFormatter : NSFormatter

/** The phone format string. Default is '(###) ###-####'*/
@property (strong, nonatomic) NSString * format;

@end
