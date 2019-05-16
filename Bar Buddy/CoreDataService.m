//
//  CoreDataService.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 29/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "CoreDataService.h"
#import "User+CoreDataClass.h"
//#import "User.h"
#import "AppDelegate.h"
#import "CoreDataServiceProtocol.h"
#import "CoreDataStack.h"


@interface CoreDataService () <NSFetchedResultsControllerDelegate, CoreDataServiceProtocol>

@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;


@end

@implementation CoreDataService


- (instancetype)initWithCoreDataStack:(CoreDataStack *)coreDataStack
{
    self = [super init];
    if (self)
    {
        _coreDataContext = coreDataStack.persistentContainer.viewContext;
    }
    return self;
}


- (void)saveUserData:(NSArray *)users;
{
    [self deleteUsersFromCoreData];
    
    for (NSDictionary *json in users)
    {
        [self.coreDataContext performBlockAndWait:^{
            User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.coreDataContext];
            
            NSString *displayedName = json[@"displayed_name"];
            NSString *userName = json[@"user_name"];
            NSString *userpicURL = json[@"userpic_url"];
            NSInteger preferredDrink = [json[@"preferred_drink"] intValue];
            NSInteger preferredCompany = [json[@"preferred_company"] integerValue];
            NSNumber *latitude = [NSNumber numberWithFloat: [json[@"latitude"] floatValue]];
            NSNumber *longitude = [NSNumber numberWithFloat: [json[@"longitude"] floatValue]];
            
            user.displayedName = displayedName;
            user.userName = userName;
            user.userpicURL = userpicURL;
            user.preferredDrink = preferredDrink;
            user.preferredCompany = preferredCompany;
            user.locationLatitude = latitude.doubleValue;
            user.locationLongitude = longitude.doubleValue;
            
            NSError *error = nil;
            if (![self.coreDataContext save:&error])
            {
                NSLog(@"Error saving: %@", error);
            }
        }];
    }
}


- (NSArray<User *> *)getUserData
{
    NSArray *users = [self updatedArray];
    return users;
}

- (NSArray<User *> *)getFilteredUsersWithDrinkType:(NSInteger)drinkType withCompanyType:(NSInteger)companyType
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    //    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userName CONTAINS %@ OR preferredDrink CONTAINS %@", @"vasiliy12345", @2];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"preferredDrink == %d", drinkType];
    
    //    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:NO];
    //    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    
    
    //    [self.coreDataContext performBlockAndWait:^() {
    NSError *error = nil;
    NSArray *result = [self.coreDataContext executeFetchRequest:fetchRequest ? : [User fetchRequest] error:&error];
    //        NSLog(@"there are %ld users with drink %lu", (long)result.count, drinkType);
    return result;
    //    }]
    ;
    
    
}

- (NSArray *)updatedArray;
{
    NSError *error = nil;
    
    NSArray *result = [self.coreDataContext executeFetchRequest:self.fetchRequest ? : [User fetchRequest] error:&error];
    return result;
}

- (NSFetchRequest *)fetchRequest
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
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
                                   entityForName:NSStringFromClass([User class]) inManagedObjectContext:self.coreDataContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"userName" ascending:YES]]];
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.coreDataContext sectionNameKeyPath:nil cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

- (void)deleteUsersFromCoreData
{
    [self.coreDataContext performBlockAndWait:^() {
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
        NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
        
        NSError *deleteError = nil;
        [self.coreDataContext executeRequest:delete error:&deleteError];
    }];
}

@end
