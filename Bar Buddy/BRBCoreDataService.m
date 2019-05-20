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
#import "ProjectSettings.h"
#import "BRBParserService.h"


@interface BRBCoreDataService ()

@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, strong) NSPredicate *drinkPredicate;
@property (nonatomic, strong) NSPredicate *topicPredicate;
@property (nonatomic, nullable) NSArray<User *> *users;

@property (nonatomic) NSError *error;

@end

@implementation BRBCoreDataService

- (instancetype)initWithCoreDataStack:(BRBCoreDataStack *)coreDataStack
{
    self = [super init];
    if (self)
    {
        if (coreDataStack)
        {
            _coreDataContext = coreDataStack.persistentContainer.viewContext;
            _fetchRequest = [[NSFetchRequest alloc] initWithEntityName:BRBCoreDataEntityName];
        }
        else
        {
            return nil;
        }
        
    }
    return self;
}

- (NSArray<BRBParserService *> *)parseJSON:(NSArray<NSDictionary *> *)users
{
    NSMutableArray *array = [NSMutableArray new];
    
    for (NSDictionary *json in users)
    {
        BRBParserService *parser = [[BRBParserService alloc] initWithJSON:json];
        [array addObject:parser];
    }
    return array;
}

- (NSError *)saveUserData:(NSArray<NSDictionary *> *)users;
{
    [self deleteUsersFromCoreData];
    self.error = nil;
    
    for (NSDictionary *json in users)
    {
        [self.coreDataContext performBlockAndWait:^{
            User *user = [NSEntityDescription insertNewObjectForEntityForName:BRBCoreDataEntityName inManagedObjectContext:self.coreDataContext];
            
            BRBParserService *parser = [[BRBParserService alloc] initWithJSON:json];
            
            user.displayedName = parser.displayedName;
            user.userName = parser.userName;
            user.userpicURL = parser.userpicURL;
            user.preferredDrink = parser.preferredDrink;
            user.preferredCompany = parser.preferredCompany;
            user.preferredTopic = parser.preferredTopic;
            user.locationLatitude = parser.locationLatitude;
            user.locationLongitude = parser.locationLongitude;
            user.isDrinking = parser.isDrinking;
  
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
        self.error = error;
    }];
    
    if (self.error) {
        return nil;
    }
    else
    {
        return self.users;
    }
    
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
