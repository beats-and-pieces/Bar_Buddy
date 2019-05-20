//
//  BRBMapViewController.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRBViewControllerFactory.h"

@interface BRBMapViewController : BRBViewControllerFactory

/**
 Кастомный инициализатор, использующий зависимость от объекта модели
 
 @param dataContainer - экземпляр класса BRBDataContainer
 @return экземпляр класса UserTableViewController
 */
- (instancetype)initWithDataContainer:(BRBDataContainer *)dataContainer;


/**
 Показывает на карте конкретного пользователя

 @param userName имя пользователя, которого нужно показать
 */
- (void)displayLocationOfUserWithName:(NSString *)userName;

@end
