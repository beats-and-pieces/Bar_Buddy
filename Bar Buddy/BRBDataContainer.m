//
//  BRBDataContainer.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBDataContainer.h"
#import "User+CoreDataClass.h"
#import "AppDelegate.h"


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
        _topicValues = @[@"🏎", @"🎼", @"💼"];
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

- (void)loadingIsDoneWithDataRecieved:(NSArray *)dataRecieved
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (dataRecieved.count != 0)
        {
            [self.coreDataService saveUserData:dataRecieved];
            self.users = [self.coreDataService getUserData];
            [self.delegate updateTableView];
        }
    });
}

- (void)dowloadUserpicFromURL:(NSString *)urlString forIndexPath:(NSIndexPath *)indexPath
{
    [self.networkService dowloadUserpicFromURL:urlString forIndexPath:indexPath];
}

- (void)userpicIsLoadedWithDataReceived:(NSData *)data forIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate setUserpicForCellAtIndexPath:indexPath withData:data];
}

- (void)updateFilteredResultsWithDrinkType:(NSInteger)drinkType withCompanyType:(NSInteger)companyType;
{    
    self.users = [self.coreDataService getFilteredUsersWithDrinkType:drinkType withCompanyType:companyType];
    [self.delegate updateTableView];
}

@end
