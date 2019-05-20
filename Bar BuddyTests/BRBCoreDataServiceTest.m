//
//  BRBCoreDataServiceTest.m
//  Bar BuddyTests
//
//  Created by Anton Kuznetsov on 20/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BRBCoreDataStack.h"
#import "BRBCoreDataService.h"
#import <OCMock/OCMock.h>

@interface BRBCoreDataServiceTest : XCTestCase

@end

@implementation BRBCoreDataServiceTest


- (void)testCoreDataServiceInitialization
{
    BRBCoreDataStack *coreDataStack = [BRBCoreDataStack new];
    BRBCoreDataService *coreDataService = [[BRBCoreDataService alloc] initWithCoreDataStack:coreDataStack];
    
    XCTAssertNotNil(coreDataService, @"Cannot initialize CoreDataService");
}

- (void)testUserDataIsNotNil
{
    BRBCoreDataStack *coreDataStack = [BRBCoreDataStack new];
    BRBCoreDataService *coreDataService = [[BRBCoreDataService alloc] initWithCoreDataStack:coreDataStack];
    NSArray *userData = [coreDataService getUserData];
    
    XCTAssertNotNil(userData, @"Cannot load users");
}

- (void)testUserFiltering
{
    BRBCoreDataStack *coreDataStack = [BRBCoreDataStack new];
    BRBCoreDataService *coreDataService = [[BRBCoreDataService alloc] initWithCoreDataStack:coreDataStack];
    NSArray *userData = [coreDataService getFilteredUsersWithDrinkType:0 withTopicType:0];
    
    XCTAssertNotNil(userData, @"Cannot load filtered users");
}

- (void)testSavingUsers
{
    BRBCoreDataStack *coreDataStack = [BRBCoreDataStack new];
    BRBCoreDataService *coreDataService = [[BRBCoreDataService alloc] initWithCoreDataStack:coreDataStack];
    NSError *error = [coreDataService saveUserData:@[]];
    
//    id parserServiceMock = OCMClassMock([BRBParserService class]);
    
    XCTAssertNil(error, @"Cannot load filtered users");
}


@end
