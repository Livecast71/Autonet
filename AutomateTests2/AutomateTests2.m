//
//  AutomateTests2.m
//  AutomateTests2
//
//  Created by Livecast02 on 24/01/2019.
//  Copyright © 2019 Autonet. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface AutomateTests2 : XCTestCase

@end

@implementation AutomateTests2

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testExample2 {


    NSDateFormatter *formattertoString2 = [[NSDateFormatter alloc] init];
    [formattertoString2 setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
    [formattertoString2 setDateFormat:@"dd-MM-yyyy"];

    NSDateFormatter *formattertoString = [[NSDateFormatter alloc] init];
    [formattertoString setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
    [formattertoString setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];

    //2019-03-12T00:00:00

    NSDate *test = [formattertoString2 dateFromString:@"12-12-2019"];
    XCTAssert(false, @"test %@",test);
     XCTAssert(false, @"test %@",[formattertoString stringFromDate:test]);


    
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
