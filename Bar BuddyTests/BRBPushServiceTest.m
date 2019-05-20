//
//  BRBPushServiceTest.m
//  Bar BuddyTests
//
//  Created by Anton Kuznetsov on 20/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BRBPushService.h"

@interface BRBPushServiceTest : XCTestCase

@end

@implementation BRBPushServiceTest



- (void)testPush {
    BRBPushService *pushService = [[BRBPushService alloc] initForNotificationDelegate:nil];
    NSError *error = [pushService scheduleDrinkRequestFromUser:@""];
    XCTAssertNil(error, @"Push was unable to schedule");
}



@end
