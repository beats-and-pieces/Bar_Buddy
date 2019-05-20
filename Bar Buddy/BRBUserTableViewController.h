//
//  BRBUserTableViewController.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BRBViewControllerFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface BRBUserTableViewController : BRBViewControllerFactory

/**
 Кастомный инициализатор, принимающий зависимость от dataContainer

 @param dataContainer - экземпляр класса BRBDataContainer
 @return экземпляр класса UserTableViewController
 */
- (instancetype)initWithDataContainer:(BRBDataContainer *)dataContainer;


@end

NS_ASSUME_NONNULL_END
