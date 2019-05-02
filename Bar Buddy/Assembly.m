//
//  Assembly.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 01/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "Assembly.h"
#import "ViewControllerFactory.h"
#import "CoreDataStack.h"

@interface Assembly ()


@property (strong, nonatomic) UITabBarController *tabBarController;

@end

@implementation Assembly

- (UIViewController *)createRootViewController
{
    CoreDataService *coreDataService = [CoreDataService new];
    NetworkService *netWorkService = [NetworkService new];
    DataManager *dataManager = [[DataManager alloc] initWithCoreDataService:coreDataService withNetworkService:netWorkService];
    
    ViewControllerFactory *userTableViewController = [[ViewControllerFactory alloc] initWithDataManager:dataManager type:UserTableViewType];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:userTableViewController];
    navigationController.tabBarItem.title = [userTableViewController getTabBarItemTitle];
    
    ViewControllerFactory *mapViewController = [[ViewControllerFactory alloc] initWithDataManager:dataManager type:MapType];
    mapViewController.tabBarItem.title = [mapViewController getTabBarItemTitle];
    
    UITabBarController *tabBarViewController = [UITabBarController new];
    NSArray *viewControllerArray = @[navigationController, mapViewController];
    tabBarViewController.viewControllers = viewControllerArray;
    tabBarViewController.tabBar.translucent = YES;
    tabBarViewController.tabBar.tintColor = [UIColor whiteColor];
    tabBarViewController.tabBar.barTintColor = [UIColor blackColor];
    
    self.tabBarController = tabBarViewController;
    
    return tabBarViewController;
}

- (NSPersistentContainer *)createPersistentContainer
{
    CoreDataStack *coreDataStack = [CoreDataStack new];
    return coreDataStack.persistentContainer;
}

- (void)switchToMap
{
    [self.tabBarController setSelectedIndex:1];
}

@end
