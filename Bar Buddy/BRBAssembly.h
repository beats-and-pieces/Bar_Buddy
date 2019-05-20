//
//  Assembly.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 01/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSPersistentContainer;

NS_ASSUME_NONNULL_BEGIN

@interface BRBAssembly : NSObject

/**
 Возвращет rootViewController для App Delegate

 @return объект типа UIViewController, в данном случае barTabController
 */
- (UIViewController *)getRootViewController;


/**
 Метод ставит в расписание пуш-уведомления, имитируещее дринк-реквест от случайного пользователя
 */
- (void)scheduleDrinkRequestFromRandomUser;

@end

NS_ASSUME_NONNULL_END

