//
//  BRBPushService.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 19/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UserNotifications;

@interface BRBPushService : NSObject

/**
Инициализатор с указанием делегата, соответствующего протоколу UNUserNotificationCenterDelegate

 @param delegate делегат
 @return экземпляр класса
 */
- (instancetype)initForNotificationDelegate:(id<UNUserNotificationCenterDelegate>)delegate;

/**
 "Заводит" пуш-уведомление о дринк-реквесте от пользователя с указанным именем

 @param userName имя пользователя, который прислал реквест 
 */
- (void)scheduleDrinkRequestFromUser:(NSString *)userName;

@end
