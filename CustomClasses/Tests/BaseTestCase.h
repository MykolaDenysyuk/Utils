//
//  BaseTestCase.h
//  Utils
//
//  Created by Mykola Denysyuk on 1/26/16.
//
//

#import <XCTest/XCTest.h>
//#import <OCMock/OCMock.h>
//#import <OCHamcrest/OCHamcrest.h>
//#import <OCMockito/OCMockito.h>

@class FailureRecorder;

//--------------------------------------------------------------------

/**
 *  Base test case class
 */
@interface BaseTestCase : XCTestCase

//
- (void)assertDictionary:(NSDictionary *)d1 isEqualToDictionary:(NSDictionary *)d2 name1:(char const *)name1 name2:(char const *)name2 failureRecorder:(FailureRecorder *)failureRecorder;

/** Generates stubs for touch events */
- (UIEvent */*mock*/)stubbedTouchEventWithLocation:(CGPoint)location inView:(UIView *)view;
@end

//--------------------------------------------------------------------
// Macros:
//--------------------------------------------------------------------

#define NewFailureRecorder() \
[[FailureRecorder alloc] initWithTestCase:self filePath:__FILE__ lineNumber:__LINE__]


#define AssertEqualDictionaries(d1, d2) \
do { \
[self assertDictionary:d1 isEqualToDictionary:d2 name1:#d1 name2:#d2 failureRecorder:NewFailureRecorder()]; \
} while (0)

//--------------------------------------------------------------------
// Helper classes
//--------------------------------------------------------------------

@interface NSObject (test)
- (void)simpleMethod;
- (void)methodWithParameter:(id)param;
@end

@interface FailureRecorder : NSObject

- (instancetype)initWithTestCase:(XCTestCase *)testCase filePath:(char const *)filePath lineNumber:(NSUInteger)lineNumber;

@property (nonatomic, readonly) XCTestCase *testCase;
@property (nonatomic, readonly, copy) NSString *filePath;
@property (nonatomic, readonly) NSUInteger lineNumber;

- (void)recordFailure:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

@end