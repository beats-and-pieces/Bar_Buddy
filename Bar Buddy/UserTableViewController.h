//
//  UsersTableViewController.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserTableViewController : ViewControllerFactory

- (instancetype)initWithDataManager:(DataManager *)dataManager;
- (NSString *)getTabBarItemTitle;

@end

NS_ASSUME_NONNULL_END
