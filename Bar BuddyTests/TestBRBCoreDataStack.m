//
//  TestBRBCoreDataStack.m
//  Bar BuddyTests
//
//  Created by Anton Kuznetsov on 20/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

//@testable import Bar_Buddy

#import <XCTest/XCTest.h>
#import "co"


@interface TestBRBCoreDataStack : XCTestCase

@end

@implementation TestBRBCoreDataStack

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testCoreDataStackInitialization
{
    // setup
    BRBCoreDataStack *coreDataStack = [BRBCoreDataStack new];
    
    XCTAssertTrue([[assembly getRootViewController] isKindOfClass:[UIViewController class]], @"Cannot find ViewController instance");
    // no teardown needed
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
