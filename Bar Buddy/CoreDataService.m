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

- (void)saveUserData:(NSArray *)users;
{
    [self deleteUsersFromCoreData];
    
    for (NSDictionary *json in users)
    {
        User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.coreDataContext];
     
        NSString *displayedName = json[@"displayed_name"];
        NSString *userName = json[@"user_name"];
        NSString *userpicURL = json[@"userpic_url"];
        NSInteger preferredDrink = [json[@"preferred_drink"] intValue];
        NSInteger preferredCompany = [json[@"preferred_company"] integerValue];
        NSString *latitude = json[@"latitude"];
        NSString *longitude = json[@"longitude"];
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        float longitudeFloat = [numberFormatter numberFromString: longitude].floatValue;
        float latitudeFloat = [numberFormatter numberFromString: latitude].floatValue;
        
        user.displayedName = displayedName;
        user.userName = userName;
        user.userpicURL = userpicURL;
        user.preferredDrink = preferredDrink;
        user.preferredCompany = preferredCompany;
        user.locationLatitude = longitudeFloat;
        user.locationLongitude = latitudeFloat;
        
        NSError *error = nil;
        if (![user.managedObjectContext save:&error])
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
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"userName" ascending:NO];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    
    NSError *error = nil;
    
    NSArray *result = [self.coreDataContext executeFetchRequest:fetchRequest ? : [User fetchRequest] error:&error];
    NSLog(@"there are %ld users with drink %lu", (long)result.count, drinkType);
    return result;
}


- (NSManagedObjectContext *)coreDataContext
{
    UIApplication *application = [UIApplication sharedApplication];
    NSPersistentContainer *container = ((AppDelegate *)(application.delegate)).persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    
    return context;
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
                                   entityForName:NSStringFromClass([User class]) inManagedObjectContext:self.coreDataContext];
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
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
        NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
        
        NSError *deleteError = nil;
        [self.coreDataContext executeRequest:delete error:&deleteError];
    }];
}

@end
