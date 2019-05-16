//
//  CoreDataService.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 29/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "CoreDataService.h"
#import "User+CoreDataClass.h"
#import "AppDelegate.h"
#import "CoreDataServiceProtocol.h"
#import "CoreDataStack.h"


@interface CoreDataService () <CoreDataServiceProtocol>

@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;

@end

@implementation CoreDataService


- (instancetype)initWithCoreDataStack:(CoreDataStack *)coreDataStack
{
    self = [super init];
    if (self)
    {
        _coreDataContext = coreDataStack.persistentContainer.viewContext;
        _fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
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
    //    NSArray *users = [self updatedArray];
    //    [self.coreDataContext performBlockAndWait:^() {
    NSError *error = nil;
    return [self.coreDataContext executeFetchRequest:self.fetchRequest ? : [User fetchRequest] error:&error];
    //    }];
}

- (NSArray<User *> *)getFilteredUsersWithDrinkType:(NSInteger)drinkType withCompanyType:(NSInteger)companyType
{
    
    self.fetchRequest.predicate = [NSPredicate predicateWithFormat:@"preferredDrink == %d", drinkType];
    //    [self.coreDataContext performBlockAndWait:^() {
    NSError *error = nil;
    NSArray *result = [self.coreDataContext executeFetchRequest:self.fetchRequest ? : [User fetchRequest] error:&error];
    //        NSLog(@"there are %ld users with drink %lu", (long)result.count, drinkType);
    return result;
    //    }]
    ;
    
}

- (void)deleteUsersFromCoreData
{
    [self.coreDataContext performBlockAndWait:^() {
        NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:self.fetchRequest];
        
        NSError *deleteError = nil;
        [self.coreDataContext executeRequest:delete error:&deleteError];
    }];
}

@end
