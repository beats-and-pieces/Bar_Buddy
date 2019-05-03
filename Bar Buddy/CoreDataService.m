//
//  CoreDataService.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 29/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "CoreDataService.h"
#import "UserCD+CoreDataClass.h"
#import "User.h"
#import "AppDelegate.h"
#import "CoreDataServiceProtocol.h"
#import "CoreDataStack.h"


@interface CoreDataService () <NSFetchedResultsControllerDelegate, CoreDataServiceProtocol>

@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;


@end

@implementation CoreDataService

- (void)saveUserData:(NSArray<User *> *)users;
{
    [self deleteUsersFromCoreData];
    
    for (User *user in users)
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
        
        __block BOOL savedOK = NO;
        [self.coreDataContext performBlockAndWait:^{
            // Do lots of things with the context.
            NSError *error = nil;
            if (![self.coreDataContext save:&error]) {
                NSLog(@"Error saving: %@", error);    } else {
                    savedOK = YES;
                }
        }];
    }
}


- (NSArray<UserCD *> *)getUserData
{
    NSArray *users = [self updatedArray];
    return users;
}

- (NSArray<UserCD *> *)getFilteredUsersWithDrinkType:(NSInteger)drinkType withCompanyType:(NSInteger)companyType
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"UserCD"];
    //    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userName CONTAINS %@ OR preferredDrink CONTAINS %@", @"vasiliy12345", @2];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"preferredDrink == %d", drinkType];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:NO];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    
    NSError *error = nil;
    
    NSArray *result = [self.coreDataContext executeFetchRequest:fetchRequest ? : [UserCD fetchRequest] error:&error];
    NSLog(@"there are %ld users with drink %lu", (long)result.count, drinkType);
    return result;
}


- (NSManagedObjectContext *)coreDataContext
{
    UIApplication *application = [UIApplication sharedApplication];
    
    //    CoreDataStack *coreDataStack = [CoreDataStack new];
    //        NSLog(@"getLocalData");
    //        [self.delegate updateData];
    
    
    //    NSPersistentContainer *container = coreDataStack.persistentContainer;
    NSPersistentContainer *container = ((AppDelegate *)(application.delegate)).persistentContainer;
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
    
    
    NSError *error;
    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.coreDataContext sectionNameKeyPath:nil cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    
    
    
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

- (void)deleteUsersFromCoreData
{
    [self.coreDataContext performBlockAndWait:^() {
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"UserCD"];
        NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
        
        NSError *deleteError = nil;
        [self.coreDataContext executeRequest:delete error:&deleteError];
    }];
}

@end
