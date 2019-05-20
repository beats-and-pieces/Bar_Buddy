//
//  BRBAssemblyTest.m
//  Bar BuddyTests
//
//  Created by Anton Kuznetsov on 20/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BRBAssembly.h"

@interface BRBAssemblyTest : XCTestCase

@end

@implementation BRBAssemblyTest

- (void) testRootViewControllerIsNotNil {
    BRBAssembly *assembly = [BRBAssembly new];
    
    XCTAssertNotNil([assembly getRootViewController], @"ViewController is nil");
}

- (void) testRootViewControllerIsUIViewcontroller {
    BRBAssembly *assembly = [BRBAssembly new];
    
    XCTAssertTrue([[assembly getRootViewController] isKindOfClass:[UIViewController class]], @"Cannot find ViewController instance");
}

@end
