//
//  BRBAlertController.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 18/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRBAlertController : NSObject

@property (nonatomic, nullable, weak) UIViewController *delegate; /**< Делегат внешних событий */

/**
 Инициализатор с привязкой к делегату, на который будут посылаться алерты

 @param viewController - делегат
 @return экземпляр своего класса
 */
- (instancetype)initWithViewController:(UIViewController *)viewController;


/**
 Показывает алерт для случая успешного "посыла" дринк-реквеста

 @param userName отображаемое в алерте имя пользователя
 */
- (void)showAlertForDrinkRequestTo:(NSString *)userName;


/**
 Метод показывает алерт для случая невозможности "посыла" дринк-реквеста
 
 @param userName отображаемое в алерте имя пользователя
 */
- (void)showAlertForUnableToSendDrinkRequestTo:(NSString *)userName;

@end

NS_ASSUME_NONNULL_END
