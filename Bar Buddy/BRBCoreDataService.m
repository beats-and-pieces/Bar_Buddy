//
//  BRBCoreDataService.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 29/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBCoreDataService.h"
#import "User+CoreDataClass.h"
#import "AppDelegate.h"
#import "BRBCoreDataStack.h"


@interface BRBCoreDataService ()

@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, strong) NSPredicate *drinkPredicate;
@property (nonatomic, strong) NSPredicate *topicPredicate;
@property (nonatomic) NSArray<User *> *users;

@property (nonatomic) NSError *error;

@end

@implementation BRBCoreDataService

- (instancetype)initWithCoreDataStack:(BRBCoreDataStack *)coreDataStack
{
    self = [super init];
    if (self)
    {
        _coreDataContext = coreDataStack.persistentContainer.viewContext;
        _fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    }
    return self;
}


- (NSError *)saveUserData:(NSArray<User *> *)users;
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
            NSInteger preferredTopic = [json[@"preferred_topic"] integerValue];
            NSNumber *latitude = [NSNumber numberWithFloat: [json[@"latitude"] floatValue]];
            NSNumber *longitude = [NSNumber numberWithFloat: [json[@"longitude"] floatValue]];
            BOOL isDrinking = NO;
            if ([json[@"isDrinking"] isEqualToString:@"TRUE"])
            {
                isDrinking = YES;
            }
            user.displayedName = displayedName;
            user.userName = userName;
            user.userpicURL = userpicURL;
            user.preferredDrink = preferredDrink;
            user.preferredCompany = preferredCompany;
            user.preferredTopic = preferredTopic;
            user.locationLatitude = latitude.doubleValue;
            user.locationLongitude = longitude.doubleValue;
            user.isDrinking = isDrinking;
        
            NSError *error = nil;
            if (![self.coreDataContext save:&error])
            {
                self.error = error;
            }
        }];
    }
    return self.error;
}


- (NSArray<User *> *)getUserData
{
    [self.coreDataContext performBlockAndWait:^() {
        NSError *error = nil;
        self.users = [self.coreDataContext executeFetchRequest:self.fetchRequest ? : [User fetchRequest] error:&error];
    }];
    return self.users;
}


- (NSArray<User *> *)getFilteredUsersWithDrinkType:(NSInteger)drinkType withTopicType:(NSInteger)topicType
{
    if (drinkType == 0)
    {
        self.drinkPredicate = [NSPredicate predicateWithFormat:@"preferredDrink != %d", drinkType];;
    }
    else
    {
        self.drinkPredicate = [NSPredicate predicateWithFormat:@"preferredDrink == %d", drinkType];
    }
    
    if (topicType == 0)
    {
        self.topicPredicate = [NSPredicate predicateWithFormat:@"preferredTopic != %d", topicType];;
    }
    else
    {
        self.topicPredicate = [NSPredicate predicateWithFormat:@"preferredTopic == %d", topicType];
    }
    
    self.fetchRequest.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[self.drinkPredicate, self.topicPredicate]];
    
    return [self getUserData];
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
