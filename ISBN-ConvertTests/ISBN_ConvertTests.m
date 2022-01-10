//
//  ISBN_ConvertTests.m
//  ISBN-ConvertTests
//
//  Created by Joshua Endter on 1/9/22.
//

#import <XCTest/XCTest.h>
#import "ISBNConverter.h"

@interface ISBN_ConvertTests : XCTestCase

@end

@implementation ISBN_ConvertTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testSuccessfulProductIDConversion {
    XCTAssert([[ISBNConverter isbnFromProductID:@"978155192370"] isEqualToString:@"155192370x"]);
    XCTAssert([[ISBNConverter isbnFromProductID:@"978140007917"] isEqualToString:@"1400079179"]);
    XCTAssert([[ISBNConverter isbnFromProductID:@"978037541457"] isEqualToString:@"0375414576"]);
    XCTAssert([[ISBNConverter isbnFromProductID:@"978037428158"] isEqualToString:@"0374281580"]);
}

- (void)testProductIDInvalidLength {
    XCTAssert([ISBNConverter isbnFromProductID:@"97815519237"] == nil);
}

- (void)testProductIDInvalidCharacters {
    XCTAssert([ISBNConverter isbnFromProductID:@"97803742815a"] == nil);
}

@end
