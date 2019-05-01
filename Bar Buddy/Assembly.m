//
//  Assembly.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 01/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "Assembly.h"

#import "UserTableViewController.h"
#import "MapViewController.h"
#import "ViewControllerFactory.h"


@implementation Assembly

- (UIViewController *)createRootViewController
{
    DataManager *dataManager = [DataManager shared];
    ViewControllerFactory *userTableViewController = [[ViewControllerFactory alloc] initWithDataManager:dataManager type:UserTableViewType];
//    UserTableViewController *userTableViewController = [[UserTableViewController alloc] init];
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:userTableViewController];
    
    navigationController.tabBarItem.title = [userTableViewController getTabBarItemTitle];
//    navigationController.tabBarItem.title = userTableViewController
    ViewControllerFactory *mapViewController = [[ViewControllerFactory alloc] initWithDataManager:dataManager type:MapType];
//    MapViewController *mapViewController = [[MapViewController alloc] init];
    mapViewController.tabBarItem.title = @"На карте";
    
    NSArray *viewControllerArray = @[navigationController, mapViewController];
    UITabBarController *tabBarViewController = [[UITabBarController alloc] init];
    tabBarViewController.tabBar.translucent = YES;
    tabBarViewController.tabBar.tintColor = [UIColor whiteColor];
    tabBarViewController.tabBar.barTintColor = [UIColor blackColor];
    tabBarViewController.viewControllers = viewControllerArray;
    
    return tabBarViewController;
}
@end
