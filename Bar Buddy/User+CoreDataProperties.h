//
//  User+CoreDataProperties.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 19/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *displayedName;
@property (nonatomic) BOOL isDrinking;
@property (nonatomic) double locationLatitude;
@property (nonatomic) double locationLongitude;
@property (nonatomic) int16_t preferredCompany;
@property (nonatomic) int16_t preferredDrink;
@property (nullable, nonatomic, copy) NSString *userName;
@property (nullable, nonatomic, copy) NSString *userpicURL;
@property (nonatomic) int16_t preferredTopic;

@end

NS_ASSUME_NONNULL_END
