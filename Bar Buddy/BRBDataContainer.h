//
//  BRBDataContainer.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRBCoreDataService.h"
#import "BRBNetworkService.h"

@protocol BRBDataContainerDelegateProtocol <NSObject>

- (void)updateTableView;
- (void)setUserpicForCellAtIndexPath:(NSIndexPath *)indexPath withData:(NSData *)data;

@end


@interface BRBDataContainer : NSObject 

@property (nonatomic, nullable, copy) NSArray<User *> *users; /**< Массив пользователей */
@property (nonatomic, copy) NSArray<NSString *> *drinkValues; /**< Массив значений фильтра предпочитаемых напитков */
@property (nonatomic, copy) NSArray<NSString *> *topicValues; /**< Массив значений фильтра предпочитаемых для обсуждения тем */
@property (nonatomic, nullable, weak) id<BRBDataContainerDelegateProtocol> delegate; /**< Делегат, который получает измененные данные */

/**
 Инициализатор с зависимости от сетевого и CoreData сервисов
 
 @param coreDataService экземпляр сервиса CoreData
 @param networkService экземпляр сетевого сервиса
 @return экземляр собственного класса
 */
- (instancetype)initWithCoreDataService:(BRBCoreDataService *)coreDataService withNetworkService:(BRBNetworkService *)networkService;


/**
 Загружает массив пользователей users из CoreData при их наличии, затем запрашивает обновление из сети.
 В случае успешной загрузки перезаписывает их в CoreData.
 Вызывает обновление у делегата методом updateTableView по протоколу BRBDataContainerDelegateProtocol
 */
- (void)loadData;


/**
 Запрашивает обновления массива users с учетом выбранных фильтров.
 Вызывает обновление у делегата методом updateTableView по протоколу BRBDataContainerDelegateProtocol
 
 @param drinkType тип предпочитаемого напитка для фильтра
 @param topicType тип предпочитаемой темы для фильтра
 */
- (void)updateFilteredResultsWithDrinkType:(NSInteger)drinkType withTopicType:(NSInteger)topicType;


/**
 Запрашивает загрузку аватара пользователя из сети.
 По получению отправляет её делегату вызовом метода setUserpicForCellAtIndexPath из протокола BRBDataContainerDelegateProtocol
 
 @param urlString картинки, которую нужно загрузить
 @param indexPath ячейки таблицы, для которой запрошена картинка. Используется для соотнесения картинки и ячейки.
 */
- (void)dowloadUserpicFromURL:(NSString *)urlString forIndexPath:(NSIndexPath *)indexPath;

@end
