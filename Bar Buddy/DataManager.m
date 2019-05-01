//
//  DataManager.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "DataManager.h"
//#import "DataManagerProtocol.h"
//#import "NetworkService.h"
//#import "CoreDataService.h"
#import "User.h"
#import "JSONAdapter.h"
#import "UserCD+CoreDataClass.h"
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
    NSMutableArray *tempArray  = [NSMutableArray new];
    for (NSDictionary *userData in dataRecieved)
    {
        JSONAdapter *adapter = [[JSONAdapter alloc] initWithJSON:userData];
        User *user = [[User alloc] initWithJSON:adapter];
        [tempArray addObject:user];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Saving data!");
        [self.coreDataService saveUserData:tempArray];
        self.users = [self.coreDataService getUserData];
        [self.delegate updateData];
    });

}

@end
