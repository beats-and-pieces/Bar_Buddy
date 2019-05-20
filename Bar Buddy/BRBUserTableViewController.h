//
//  BRBUserTableViewController.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRBViewControllerFactory.h"

@interface BRBUserTableViewController : BRBViewControllerFactory

/**
 Кастомный инициализатор, принимающий зависимость от dataContainer

 @param dataContainer - экземпляр класса BRBDataContainer
 @return экземпляр класса UserTableViewController
 */
- (instancetype)initWithDataContainer:(BRBDataContainer *)dataContainer;


/**
 Возвращает строку для отображения в Tab Bar контроллере
 
 @return строка - название закладки данного контроллера для Tab Bar
 */
- (NSString *)getTabBarItemTitle;

@end
