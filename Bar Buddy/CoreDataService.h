//
//  CoreDataService.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 29/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User+CoreDataClass.h"
//#import "User.h"

@class CoreDataStack;

@interface CoreDataService : NSObject

- (instancetype)initWithCoreDataStack:(CoreDataStack *)coreDataStack;
- (void)saveUserData:(NSArray *)users;

- (NSArray<User *> *) getUserData;
- (NSArray<User *> *)getFilteredUsersWithDrinkType:(NSInteger)drinkType withCompanyType:(NSInteger)companyType;

@end
