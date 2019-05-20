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

/**
 Инициализатор, принимающий словарь с данными JSON

 @param json данные JSON
 @return экземпляр собственного класса
 */
- (instancetype)initWithJSON:(NSDictionary *)json;


//Список свойств, идентичных один к одному классу User сущности CoreData
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
