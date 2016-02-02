//
//  XPhoneFormatterTest.m
//  Utils
//
//  Created by Mykola Denysyuk on 6/18/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XPhoneFormatter.h"

@interface XPhoneFormatterTest : XCTestCase

@end

@implementation XPhoneFormatterTest

- (void)test
{
    NSString * inputString = @"0123456789";
    NSString * expectedOutput = @"(012) 345-6789";
    XPhoneFormatter* formatter = [XPhoneFormatter new];
    XCTAssert([[formatter stringForObjectValue:inputString] isEqualToString:expectedOutput], @"Pass");
}

@end
