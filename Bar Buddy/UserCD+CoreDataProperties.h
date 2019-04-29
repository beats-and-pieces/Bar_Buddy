//
//  UserCD+CoreDataProperties.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 29/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//
//

#import "UserCD+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserCD (CoreDataProperties)

+ (NSFetchRequest<UserCD *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *displayedName;
@property (nullable, nonatomic, copy) NSString *userName;
@property (nonatomic) int16_t preferredDrink;
@property (nonatomic) int16_t preferredCompany;
@property (nonatomic) double locationLatitude;
@property (nonatomic) double locationLongitude;

@end

NS_ASSUME_NONNULL_END
