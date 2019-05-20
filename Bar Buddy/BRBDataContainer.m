//
//  BRBDataContainer.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBDataContainer.h"
#import "BRBCoreDataService.h"
#import "AppDelegate.h"
#import "BRBParserService.h"

@interface BRBDataContainer () <BRBNetworkServiceOutputProtocol>

@property (nonatomic, nullable) BRBNetworkService *networkService;
@property (nonatomic, nullable) BRBCoreDataService *coreDataService;

@end

@implementation BRBDataContainer

- (instancetype)initWithCoreDataService:(BRBCoreDataService *)coreDataService withNetworkService:(BRBNetworkService *)networkService
{
    self = [super init];
    if (self) {
        _coreDataService = coreDataService;
        _networkService = networkService;
        _networkService.output = self;
        _drinkValues = @[@"🍺", @"🍷", @"🥃"];
        _topicValues = @[@"⚽️", @"🎼", @"💼"];
    }
    return self;
}

- (void)loadData
{
    [self getLocalData];
    [self getDataFromServer];
}

- (void)getLocalData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.users = [self.coreDataService getUserData];
        [self.delegate updateTableView];
    });
}

- (void)getDataFromServer
{
    [self.networkService fetchUserData];
}

- (void)loadingIsDoneWithDataRecieved:(NSArray<NSDictionary *> *)dataRecieved
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (dataRecieved)
        {
            [self.coreDataService saveUserData:[self parseJSON:dataRecieved]];
            self.users = [self.coreDataService getUserData];
            [self.delegate updateTableView];
        }
    });
}

- (NSArray<BRBParserService *> *)parseJSON:(NSArray<NSDictionary *> *)users
{
    NSMutableArray *array = [NSMutableArray new];
    
    for (NSDictionary *json in users)
    {
        BRBParserService *parser = [[BRBParserService alloc] initWithJSON:json];
        [array addObject:parser];
    }
    return array;
}

- (void)dowloadUserpicFromURL:(NSString *)urlString forIndexPath:(NSIndexPath *)indexPath
{
    [self.networkService dowloadUserpicFromURL:urlString forIndexPath:indexPath];
}

- (void)userpicIsLoadedWithDataReceived:(NSData *)data forIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate setUserpicForCellAtIndexPath:indexPath withData:data];
}

- (void)updateFilteredResultsWithDrinkType:(NSInteger)drinkType withTopicType:(NSInteger)topicType;
{    
    self.users = [self.coreDataService getFilteredUsersWithDrinkType:drinkType withTopicType:topicType];
    [self.delegate updateTableView];
}

@end
