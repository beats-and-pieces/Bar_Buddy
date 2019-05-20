//
//  BRBCoreDataService.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 29/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User+CoreDataClass.h"
@class BRBCoreDataStack;
@class BRBParserService;


@interface BRBCoreDataService : NSObject

/**
 Инициализатор с зависимостью от CoreDataStack

 @param coreDataStack экземпляр
 @return экземпляр собственного типа
 */
- (instancetype)initWithCoreDataStack:(BRBCoreDataStack *)coreDataStack;


/**
 Сохраняет переданный массив пользователей в CoreData, предварительно удалив все записи из неё.
 Используется при получении нового массива из сети.

 @param users массив пользователей
 */
- (NSError *)saveUserData:(NSArray<BRBParserService *> *)users;


/**
 Возвращает массив пользователей, хранимый в CoreData

 @return массив пользователей User
 */
- (NSArray<User *> *) getUserData;

/**
 Возвращает массив отфильтрованных по параметрам пользователей

 @param drinkType фильтр-параметр "тип напитка"
 @param topicType фильтр-параметр "тип темы"
 @return массив пользователей User
 */
- (NSArray<User *> *)getFilteredUsersWithDrinkType:(NSInteger)drinkType withTopicType:(NSInteger)topicType;

@end
