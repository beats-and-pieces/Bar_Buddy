//
//  BRBNetworkServiceTest.m
//  Bar BuddyTests
//
//  Created by Anton Kuznetsov on 20/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BRBNetworkService.h"
#import <OCMock/OCMock.h>

@interface BRBNetworkServiceTest : XCTestCase

@end

@implementation BRBNetworkServiceTest

- (void)testFetchingUserData
{
    BRBNetworkService *networkService = [BRBNetworkService new];
    NSError *error = [networkService fetchUserData];
    XCTAssertNil(error, @"There was no error while fetching users");
}

- (void)testDowloadUserpicFromURL
{
    BRBNetworkService *networkService = [BRBNetworkService new];
    id indexPathServiceMock = OCMClassMock([NSIndexPath class]);
    NSString *urlString = @"https://bar-buddy.ams3.digitaloceanspaces.com/userpics/Schumacher.png";
    NSError *error = [networkService dowloadUserpicFromURL:urlString forIndexPath:indexPathServiceMock];
    XCTAssertNil(error, @"There was no error while downloading userpic");
}

@end
