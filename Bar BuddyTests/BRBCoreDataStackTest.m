//
//  BRBCoreDataStackTest.m
//  Bar BuddyTests
//
//  Created by Anton Kuznetsov on 20/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BRBCoreDataStack.h"
@interface BRBCoreDataStackTest : XCTestCase

@end

@implementation BRBCoreDataStackTest

- (void)testCoreDataStackInitialization
{
    BRBCoreDataStack *coreDataStack = [BRBCoreDataStack new];
    XCTAssertNil(coreDataStack.error, @"Cannot find ViewController instance");
}


@end
