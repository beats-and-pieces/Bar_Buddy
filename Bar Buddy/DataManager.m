//
//  DataManager.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "DataManager.h"
#import "NetworkService.h"
#import "DataManagerProtocol.h"
#import "User.h"
#import "JSONAdapter.h"
#import <CoreData/CoreData.h>

@interface DataManager ()

@property (nonatomic, strong) NetworkService *networkService;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

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

- (instancetype)init {
    if (self = [super init]) {
        //        users = @[
        //                  @"Корова",
        //                  @"Собака",
        //                  @"Жираф",
        //                  @"Страус",
        //                  @"Лисица",
        //                  @"Кошка"
        //                  ];
        //        [self getDataFromServer];
        //        [self.networkService configureUrlSessionWithParams:nil];
    }
    return self;
}

- (void)getDataFromServer
{
    self.networkService = [NetworkService new];
    NSLog(@"NetworkService is init");
    self.networkService.output = self;
    [self.networkService fetchUserData];
}

- (void)loadRecordsFromCoreData
{
    
}

- (void)loadingIsDoneWithDataRecieved:(NSArray *)dataRecieved
{
    //    NSLog(@"Total users dataRecieved %ld", (long)dataRecieved.count);
    NSLog(@"loadingIsDoneWithDataRecieved");
    NSMutableArray *tempArray  = [NSMutableArray new];
    for (NSDictionary *userData in dataRecieved)
    {
        JSONAdapter *adapter = [[JSONAdapter alloc] initWithJSON:userData];
        User *user = [[User alloc] initWithJSON:adapter];
        //        User *user = [[User alloc] ini];
        [tempArray addObject:user];
                NSLog(@"User lat! %f", user.locationLatitude);
        //        NSLog(@"Array %@", tempArray);
    }
    
    self.users = [tempArray copy];
    NSLog(@"Total users %ld", (long)self.users.count);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%@", dataRecieved);
        [self.delegate updateData];
    });
}




@end
