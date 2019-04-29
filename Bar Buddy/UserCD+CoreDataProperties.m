//
//  UserCD+CoreDataProperties.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 29/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//
//

#import "UserCD+CoreDataProperties.h"

@implementation UserCD (CoreDataProperties)

+ (NSFetchRequest<UserCD *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"UserCD"];
}

@dynamic displayedName;
@dynamic userName;
@dynamic preferredDrink;
@dynamic preferredCompany;
@dynamic locationLatitude;
@dynamic locationLongitude;

@end
