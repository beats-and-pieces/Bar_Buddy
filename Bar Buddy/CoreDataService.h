//
//  CoreDataService.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 29/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserCD+CoreDataClass.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataService : NSObject

- (NSArray<UserCD *> *) getUserData;
- (void)saveUserData:(NSArray<User *> *)users;
- (NSArray<UserCD *> *)getFilteredUsersWithDrinkType:(NSInteger)drinkType withCompanyType:(NSInteger)companyType;

@end

NS_ASSUME_NONNULL_END
