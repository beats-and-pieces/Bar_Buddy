//
//  DataManager.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "DataManager.h"
#import "DataManagerProtocol.h"
#import "NetworkService.h"
#import "User.h"
#import "JSONAdapter.h"
#import "UserCD+CoreDataClass.h"
#import "AppDelegate.h"
#import "CoreDataService.h"

@interface DataManager () <NetworkServiceOutputProtocol>

@property (nonatomic, strong) NetworkService *networkService;
@property (nonatomic, strong) CoreDataService *coreDataService;

@end

@implementation DataManager

@synthesize users;

#pragma mark Singleton Methods

+ (id)shared {
    static DataManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (void)loadData
{
    [self getLocalData];
    [self getDataFromServer];
}

- (void)getLocalData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        CoreDataService *coreDataService = [CoreDataService new];
        self.users = [coreDataService getUserData];
        [self.delegate updateData];
    });
}

- (void)getDataFromServer
{
    self.networkService = [NetworkService new];
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
        CoreDataService *coreDataService = [CoreDataService new];
        [coreDataService saveUserData:tempArray];
        self.users = [coreDataService getUserData];
        [self.delegate updateData];
    });

}

@end
