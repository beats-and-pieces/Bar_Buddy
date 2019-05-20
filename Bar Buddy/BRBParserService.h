//
//  BRBParserService.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 20/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User+CoreDataClass.h"
NS_ASSUME_NONNULL_BEGIN

@interface BRBParserService : NSObject

- (instancetype)initWithJSON:(NSDictionary *)json;

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
