//
//  testAssembly.m
//  Bar BuddyTests
//
//  Created by Anton Kuznetsov on 16/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BRBAssembly.h"

@interface testAssembly : XCTestCase

@end

@implementation testAssembly


- (void) testGettingViewController {
    // setup
    BRBAssembly *assembly = [BRBAssembly new];
    
    XCTAssertNotNil([assembly getRootViewController], @"Cannot find ViewController instance");
    // no teardown needed
}

- (void) testGettingViewControllerTwo {
    // setup
    BRBAssembly *assembly = [BRBAssembly new];
    
     XCTAssertTrue([[assembly getRootViewController] isKindOfClass:[UIViewController class]], @"Cannot find ViewController instance");
    // no teardown needed


}


@end
