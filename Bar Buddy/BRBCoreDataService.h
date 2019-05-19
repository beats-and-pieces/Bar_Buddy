//
//  CoreDataService.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 29/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User+CoreDataClass.h"
@class BRBCoreDataStack;


@interface BRBCoreDataService : NSObject

- (instancetype)initWithCoreDataStack:(BRBCoreDataStack *)coreDataStack;
- (void)saveUserData:(NSArray<User *> *)users;
- (NSArray<User *> *) getUserData;
- (NSArray<User *> *)getFilteredUsersWithDrinkType:(NSInteger)drinkType withTopicType:(NSInteger)topicType;

@end
