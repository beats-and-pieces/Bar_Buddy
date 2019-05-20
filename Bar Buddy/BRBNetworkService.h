//
//  BRBNetworkService.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 26/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;


@protocol BRBNetworkServiceOutputProtocol <NSObject>

- (void)loadingIsDoneWithDataRecieved:(NSArray<User *> *)dataRecieved;
- (void)userpicIsLoadedWithDataReceived:(NSData *)data forIndexPath:(NSIndexPath *)indexPath;

@end


@interface BRBNetworkService : NSObject

@property (nonatomic, nullable, weak) id<BRBNetworkServiceOutputProtocol> output; /**< Делегат внешних событий */

/**
Инициирует загрузку данных пользователей из сети. По завершению у делегата вызывается метод loadingIsDoneWithDataRecieved с передачей туда массива полученных пользователей.
 */
- (NSError *)fetchUserData;


/**
 Инициирует загрузку аватарки конкретного пользователя из сети.
 
 По завершению у делегата вызывается метод userpicIsLoadedWithDataReceived:forIndexPath: с передачей туда полученного содержимого типа NSData, а также indexPath ячейки, для который изначально запрашивалась аватарка.

 @param urlString адрес картинки
 @param indexPath ячейки таблицы
 */
- (NSError *)dowloadUserpicFromURL:(NSString *)urlString forIndexPath:(NSIndexPath *)indexPath;

@end
