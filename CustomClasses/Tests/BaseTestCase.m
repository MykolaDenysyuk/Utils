//
//  BaseTestCase.m
//  Utils
//
//  Created by Mykola Denysyuk on 1/26/16.
//
//

#import "BaseTestCase.h"

//--------------------------------------------------------------------
@implementation BaseTestCase

#pragma mark - Configurations

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Helpers:

- (void)assertDictionary:(NSDictionary *)d1 isEqualToDictionary:(NSDictionary *)d2 name1:(char const *)name1 name2:(char const *)name2 failureRecorder:(FailureRecorder *)failureRecorder;
{
    NSSet *keys1 = [NSSet setWithArray:d1.allKeys];
    NSSet *keys2 = [NSSet setWithArray:d2.allKeys];
    if (! [keys1 isEqualToSet:keys2]) {
        XCTFail(@"Keys don't match for %s and %s", name1, name2);
        NSMutableSet *missingKeys = [keys1 mutableCopy];
        [missingKeys minusSet:keys2];
        if (0 < missingKeys.count) {
            [failureRecorder recordFailure:@"%s is missing keys: '%@'",
             name1, [[missingKeys allObjects] componentsJoinedByString:@"', '"]];
        }
        NSMutableSet *additionalKeys = [keys2 mutableCopy];
        [additionalKeys minusSet:keys1];
        if (0 < additionalKeys.count) {
            [failureRecorder recordFailure:@"%s has additional keys: '%@'",
             name1, [[additionalKeys allObjects] componentsJoinedByString:@"', '"]];
        }
    }
    for (id key in keys1) {
        if (! [d1[key] isEqual:d2[key]]) {
            [failureRecorder recordFailure:@"Value for '%@' in '%s' does not match '%s'. %@ == %@",
             key, name1, name2, d1[key], d2[key]];
        }
    }
}

- (UIEvent *)stubbedTouchEventWithLocation:(CGPoint)location inView:(UIView *)view {
//    UITouch * touchMock = OCMClassMock([UITouch class]);
//    [OCMStub([touchMock locationInView:view]) andReturnValue:[NSValue valueWithCGPoint:location]];
//    NSSet * touches = [NSSet setWithObject:touchMock];
//    UIEvent * eventMock = OCMClassMock([UIEvent class]);
//    [OCMStub([eventMock allTouches]) andReturn:touches];
//    
//    return eventMock;
    return nil;
}

@end

// Helpers:
//--------------------------------------------------------------------

@implementation NSObject (test)
- (void)simpleMethod {};
- (void)methodWithParameter:(id)param {};
@end

@implementation FailureRecorder

- (instancetype)initWithTestCase:(XCTestCase *)testCase filePath:(const char *)filePath lineNumber:(NSUInteger)lineNumber {
    if (self = [super init]) {
        _testCase = testCase;
        _filePath = [NSString stringWithCString:filePath
                                       encoding:NSUTF8StringEncoding];
        _lineNumber = lineNumber;
    }
    return self;
}

- (void)recordFailure:(NSString *)format, ...; {
    va_list ap;
    va_start(ap, format);
    NSString *d = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    [self.testCase recordFailureWithDescription:d inFile:self.filePath atLine:self.lineNumber expected:YES];
}
@end