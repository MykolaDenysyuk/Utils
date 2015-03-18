//
//  UtilsTests.m
//  UtilsTests
//
//  Created by Mykola Denysyuk on 11/11/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface UtilsTests : XCTestCase

@end

@implementation UtilsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
}

- (void)testArrays{
    
#define aNumber 0x000abbbbbbbbcccc
    
    NSNumber * firstNumberVar = @(aNumber);
    NSNumber * secondsNumberVar = @(aNumber);
    NSNumber * thirdNumberVar = @(aNumber);
    NSNumber * forthNumberVar = @(aNumber);
    
    BOOL isSame = firstNumberVar == secondsNumberVar;
    isSame = secondsNumberVar == thirdNumberVar;
    isSame = thirdNumberVar == forthNumberVar;
    isSame = forthNumberVar == firstNumberVar;
    
    NSDictionary * values = NSDictionaryOfVariableBindings(firstNumberVar, secondsNumberVar, thirdNumberVar, forthNumberVar);
    NSArray * numbers = values.allValues;//@[firstNumberVar, secondsNumberVar, thirdNumberVar, forthNumberVar];
    
    [values enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        BOOL isContain = [numbers containsObject:obj];
        
        NSLog(@"%@ <%p>: %@. numbers contains object: %@", key, obj, obj, isContain ? @"YES":@"NO");
    }];
    
}

@end
