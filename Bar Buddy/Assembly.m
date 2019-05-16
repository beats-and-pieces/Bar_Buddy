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
#import "PushService.h"

@interface Assembly () <UNUserNotificationCenterDelegate>


@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) PushService *pushService;

@end

@implementation Assembly

- (UIViewController *)createRootViewController
{
    PushService *pushService = [[PushService alloc] initForNotificationDelegate:self];
    self.pushService = pushService;
    CoreDataStack *coreDataStack = [CoreDataStack new];
//    CoreDataService *coreDataService = [CoreDataService new];
    CoreDataService *coreDataService = [[CoreDataService alloc] initWithCoreDataStack:coreDataStack];
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

- (void)sheduleLocalNotification
{
    [self.pushService sheduleLocalNotification];
}

#pragma mark - UNUserNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler
{
    UNNotificationContent *content = response.notification.request.content;
    if (content.userInfo[@"request"])
    {
        NSString *request = content.userInfo[@"request"];
        [self switchToMap];
    }
    
    if (completionHandler)
    {
        completionHandler();
    }
}


@end
