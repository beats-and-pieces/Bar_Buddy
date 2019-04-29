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


@interface CoreDataService () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;


@end

@implementation CoreDataService


//@property (nonatomic, copy) NSArray<User *> *users;
- (void)saveUsersToCoreData:(NSArray<User *>*)users
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
    }
    
}

- (NSArray<UserCD *> *)getUserData
{
    NSArray *users = [self updatedArray];
    for (UserCD *user in users)
    {
        NSLog(@"Username: %@", user.displayedName);
    }
    return users;
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
