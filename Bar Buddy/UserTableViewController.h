//
//  UsersTableViewController.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerFactory.h"

@interface UserTableViewController : ViewControllerFactory

/**
 Кастомный инициализатор, использующий зависимость от DataManager

 @param dataManager - экземпляр класса DataManager
 @return экземпляр класса UserTableViewController
 */
- (instancetype)initWithDataManager:(DataManager *)dataManager;

/**
 Метод возвращает строку для отображения в Tab Bar контроллере
 
 @return строка - название закладки данного контроллера для Tab Bar
 */
- (NSString *)getTabBarItemTitle;

@end
