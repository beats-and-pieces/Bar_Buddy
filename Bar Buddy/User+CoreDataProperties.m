//
//  User+CoreDataProperties.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 19/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"User"];
}

@dynamic displayedName;
@dynamic isDrinking;
@dynamic locationLatitude;
@dynamic locationLongitude;
@dynamic preferredCompany;
@dynamic preferredDrink;
@dynamic userName;
@dynamic userpicURL;
@dynamic preferredTopic;

@end
