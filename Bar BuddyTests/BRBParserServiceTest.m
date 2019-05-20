//
//  BRBParserServiceTest.m
//  Bar BuddyTests
//
//  Created by Anton Kuznetsov on 20/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BRBParserService.h"
#import <OCMock/OCMock.h>


@interface BRBParserServiceTest : XCTestCase

@end

@implementation BRBParserServiceTest


- (void)testParsingOfUserDisplayedName
{
    NSDictionary *json = @{
                           @"displayed_name": @"Миха",
                           @"user_name": @"speedy_racer",
                           @"userpic_url": @"https://bar-buddy.ams3.digitaloceanspaces.com/userpics/Schumacher.png",
                           @"preferred_drink": @1,
                           @"preferred_topic": @1,
                           @"preferred_company": @0,
                           @"isDrinking": @"FALSE",
                           @"latitude": @55.131476,
                           @"longitude": @37.131409
                           };
    BRBParserService *parserService = [[BRBParserService alloc] initWithJSON:json];
    
    XCTAssertTrue([parserService.displayedName isEqualToString:@"Миха"], @"Strings are not equal");
}

- (void)testParsingOfUserName
{
    NSDictionary *json = @{
                           @"displayed_name": @"Миха",
                           @"user_name": @"speedy_racer",
                           @"userpic_url": @"https://bar-buddy.ams3.digitaloceanspaces.com/userpics/Schumacher.png",
                           @"preferred_drink": @1,
                           @"preferred_topic": @1,
                           @"preferred_company": @0,
                           @"isDrinking": @"FALSE",
                           @"latitude": @55.131476,
                           @"longitude": @37.131409
                           };
    BRBParserService *parserService = [[BRBParserService alloc] initWithJSON:json];
    
    XCTAssertTrue([parserService.userName isEqualToString:@"speedy_racer"], @"Strings are not equal");
}

- (void)testParsingOfUserpicURL
{
    NSDictionary *json = @{
                           @"displayed_name": @"Миха",
                           @"user_name": @"speedy_racer",
                           @"userpic_url": @"https://bar-buddy.ams3.digitaloceanspaces.com/userpics/Schumacher.png",
                           @"preferred_drink": @1,
                           @"preferred_topic": @1,
                           @"preferred_company": @0,
                           @"isDrinking": @"FALSE",
                           @"latitude": @55.131476,
                           @"longitude": @37.131409
                           };
    BRBParserService *parserService = [[BRBParserService alloc] initWithJSON:json];
    
    XCTAssertTrue([parserService.userpicURL isEqualToString:@"https://bar-buddy.ams3.digitaloceanspaces.com/userpics/Schumacher.png"], @"Strings are not equal");
}

- (void)testParsingOfUserPreferredDrink
{
    NSDictionary *json = @{
                           @"displayed_name": @"Миха",
                           @"user_name": @"speedy_racer",
                           @"userpic_url": @"https://bar-buddy.ams3.digitaloceanspaces.com/userpics/Schumacher.png",
                           @"preferred_drink": @1,
                           @"preferred_topic": @1,
                           @"preferred_company": @0,
                           @"isDrinking": @"FALSE",
                           @"latitude": @55.131476,
                           @"longitude": @37.131409
                           };
    BRBParserService *parserService = [[BRBParserService alloc] initWithJSON:json];
    
    XCTAssertTrue(parserService.preferredDrink == 1, @"Numbers are not equal");
}

- (void)testParsingOfUserPreferredTopic
{
    NSDictionary *json = @{
                           @"displayed_name": @"Миха",
                           @"user_name": @"speedy_racer",
                           @"userpic_url": @"https://bar-buddy.ams3.digitaloceanspaces.com/userpics/Schumacher.png",
                           @"preferred_drink": @1,
                           @"preferred_topic": @1,
                           @"preferred_company": @0,
                           @"isDrinking": @"FALSE",
                           @"latitude": @55.131476,
                           @"longitude": @37.131409
                           };
    BRBParserService *parserService = [[BRBParserService alloc] initWithJSON:json];
    
    XCTAssertTrue(parserService.preferredTopic == 1, @"Numbers are not equal");
}

- (void)testParsingOfUserPreferredCompany
{
    NSDictionary *json = @{
                           @"displayed_name": @"Миха",
                           @"user_name": @"speedy_racer",
                           @"userpic_url": @"https://bar-buddy.ams3.digitaloceanspaces.com/userpics/Schumacher.png",
                           @"preferred_drink": @1,
                           @"preferred_topic": @1,
                           @"preferred_company": @0,
                           @"isDrinking": @"FALSE",
                           @"latitude": @55.131476,
                           @"longitude": @37.131409
                           };
    BRBParserService *parserService = [[BRBParserService alloc] initWithJSON:json];
    
    XCTAssertTrue(parserService.preferredCompany == 0, @"Numbers are not equal");
}

- (void)testParsingOfUserIsDrinking
{
    NSDictionary *json = @{
                           @"displayed_name": @"Миха",
                           @"user_name": @"speedy_racer",
                           @"userpic_url": @"https://bar-buddy.ams3.digitaloceanspaces.com/userpics/Schumacher.png",
                           @"preferred_drink": @1,
                           @"preferred_topic": @1,
                           @"preferred_company": @0,
                           @"isDrinking": @"FALSE",
                           @"latitude": @55.131476,
                           @"longitude": @37.131409
                           };
    BRBParserService *parserService = [[BRBParserService alloc] initWithJSON:json];
    
    BOOL isDrinking = NO;
    if ([json[@"isDrinking"] isEqualToString:@"TRUE"])
    {
        isDrinking = YES;
    }
    
    XCTAssertTrue(parserService.isDrinking == isDrinking, @"True");
}

- (void)testParsingOfUserLatitude
{
    NSDictionary *json = @{
                           @"displayed_name": @"Миха",
                           @"user_name": @"speedy_racer",
                           @"userpic_url": @"https://bar-buddy.ams3.digitaloceanspaces.com/userpics/Schumacher.png",
                           @"preferred_drink": @1,
                           @"preferred_topic": @1,
                           @"preferred_company": @0,
                           @"isDrinking": @"FALSE",
                           @"latitude": @55.131476,
                           @"longitude": @37.131409
                           };
    BRBParserService *parserService = [[BRBParserService alloc] initWithJSON:json];
    NSNumber *latitude = @55.131476;
    
    XCTAssertEqualWithAccuracy(parserService.locationLatitude, latitude.doubleValue, 0.00001, "Parsing is wrong!");
}

- (void)testParsingOfUserLongitude
{
    NSDictionary *json = @{
                           @"displayed_name": @"Миха",
                           @"user_name": @"speedy_racer",
                           @"userpic_url": @"https://bar-buddy.ams3.digitaloceanspaces.com/userpics/Schumacher.png",
                           @"preferred_drink": @1,
                           @"preferred_topic": @1,
                           @"preferred_company": @0,
                           @"isDrinking": @"FALSE",
                           @"latitude": @55.131476,
                           @"longitude": @37.131409
                           };
    BRBParserService *parserService = [[BRBParserService alloc] initWithJSON:json];
    NSNumber *longitude = @37.131409;
    
    XCTAssertEqualWithAccuracy(parserService.locationLongitude, longitude.doubleValue, 0.00001, "Parsing is wrong!");
}


@end
