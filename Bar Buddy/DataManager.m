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

@interface DataManager () <NSFetchedResultsControllerDelegate, NetworkServiceOutputProtocol>

@property (nonatomic, strong) NetworkService *networkService;
@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

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
    self.networkService.output = self;
    [self.networkService fetchUserData];
}

- (void)loadData
{
    //    [self getDataFromServer];
    dispatch_async(dispatch_get_main_queue(), ^{
        CoreDataService *coreDataService = [CoreDataService new];
        //                [self saveUsersToCoreData];
        //        NSArray<UserCD *> *userDataArray =
        self.users = [coreDataService getUserData];
        [self.delegate updateData];
        //        NSLog(@"%@", dataRecieved);
        //        [self.delegate updateData];
        //        NSArray *array = [self updatedArray];
        //        for (UserCD *user in array)
        //        {
        //            NSLog(@"Username: %@", user.displayedName);
        //        }
    });
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
    //    [self saveUsersToCoreData];
    dispatch_async(dispatch_get_main_queue(), ^{
        //        [self saveUsersToCoreData];
        NSLog(@"%@", dataRecieved);
        [self.delegate updateData];
        NSArray *array = [self updatedArray];
        for (UserCD *user in array)
        {
            NSLog(@"Username: %@", user.displayedName);
        }
    });
}


- (void)saveUsersToCoreData
{
    [self deleteUsersFromCoreData];
    for (User *user in self.users)
    {
        UserCD *userCD = [NSEntityDescription insertNewObjectForEntityForName:@"UserCD" inManagedObjectContext:self.coreDataContext];
        userCD.displayedName = user.displayedName;
        userCD.userName = user.userName;
        userCD.locationLatitude = user.locationLatitude;
        userCD.locationLongitude = user.locationLongitude;
        userCD.preferredDrink = user.preferredDrink;
        userCD.preferredCompany = user.preferredCompany;
        
        NSError *error = nil;
        
        if (![userCD.managedObjectContext save:&error])
        {
            NSLog(@"Не удалось сохранить объект");
            NSLog(@"%@, %@", error, error.localizedDescription);
        }
        else
        {
            NSLog(@"Core Data saved!");
        }
    }
    
}

- (NSManagedObjectContext *)coreDataContext
{
    UIApplication *application = [UIApplication sharedApplication];
    NSPersistentContainer *container = ((AppDelegate *)(application.delegate)).
    persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    
    return context;
}

- (NSArray *)updatedArray;
{
    NSError *error = nil;
    
    NSArray *result = [self.coreDataContext executeFetchRequest:self.fetchRequest ? : [UserCD fetchRequest] error:&error];
    return result;
}

- (NSFetchRequest *)fetchRequest
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"UserCD"];
    //    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userName CONTAINS %@ OR preferredDrink CONTAINS %@", @"vasiliy12345", @2];
    //    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userName CONTAINS %@", @"sema124"];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:NO];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    return fetchRequest;
}



- (NSFetchedResultsController *)fetchedResultsController
{
    
    if (_fetchedResultsController)
    {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:NSStringFromClass([UserCD class]) inManagedObjectContext:self.coreDataContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"userName" ascending:YES]]];
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.coreDataContext sectionNameKeyPath:nil
                                                   cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

- (void)deleteUsersFromCoreData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"UserCD"];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    NSError *deleteError = nil;
    //    [self.coreDataContext executeRequest:delete withContext:myContext error:&deleteError];
    [self.coreDataContext executeRequest:delete error:&deleteError];
    //    [self.coreDataContext executeFetchRequest:delete error:&deleteError];
}
@end
