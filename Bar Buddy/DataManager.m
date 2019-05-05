//
//  DataManager.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "DataManager.h"
#import "User+CoreDataClass.h"
#import "AppDelegate.h"


@interface DataManager () <NetworkServiceOutputProtocol>

@property (nonatomic, strong) NetworkService *networkService;
@property (nonatomic, strong) CoreDataService *coreDataService;

@end

@implementation DataManager

- (instancetype)initWithCoreDataService:(CoreDataService *)coreDataService withNetworkService:(NetworkService *)networkService
{
    self = [super init];
    if (self) {
        _coreDataService = coreDataService;
        _networkService = networkService;
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
        NSLog(@"getLocalData");
        [self.delegate updateData];
    });
}

- (void)getDataFromServer
{
    self.networkService.output = self;
    [self.networkService fetchUserData];
}


- (void)loadingIsDoneWithDataRecieved:(NSArray *)dataRecieved
{
    NSLog(@"loadingIsDoneWithDataRecieved");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Saving data!");
        [self.coreDataService saveUserData:dataRecieved];
        self.users = [self.coreDataService getUserData];
        [self.delegate updateData];
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
    
//    return [self.coreDataService getFilteredUsersWithDrinkType:drinkType withCompanyType:companyType];
    self.users = [self.coreDataService getFilteredUsersWithDrinkType:drinkType withCompanyType:companyType];
    [self.delegate updateData];
}

@end
