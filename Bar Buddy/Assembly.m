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
#import "MapViewController.h"

@interface Assembly () <UNUserNotificationCenterDelegate>


@property (nonatomic, nonnull) UITabBarController *tabBarController;
@property (nonatomic, nonnull) PushService *pushService;
@property (nonatomic, nonnull) DataManager *dataManager;

@end

@implementation Assembly


- (instancetype)init
{
    self = [super init];
    if (self) {
        PushService *pushService = [[PushService alloc] initForNotificationDelegate:self];
        self.pushService = pushService;
        
        CoreDataStack *coreDataStack = [CoreDataStack new];
        CoreDataService *coreDataService = [[CoreDataService alloc] initWithCoreDataStack:coreDataStack];
        
        NetworkService *netWorkService = [NetworkService new];
        
        DataManager *dataManager = [[DataManager alloc] initWithCoreDataService:coreDataService withNetworkService:netWorkService];
        self.dataManager = dataManager;
        
        ViewControllerFactory *userTableViewController = [ViewControllerFactory initWithDataManager:dataManager type:BRBViewControllerTypeUserTableView];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:userTableViewController];
        navigationController.tabBarItem.title = [userTableViewController getTabBarItemTitle];
        
        ViewControllerFactory *mapViewController = [ViewControllerFactory initWithDataManager:dataManager type:BRBViewControllerTypeUserMap];
        mapViewController.tabBarItem.title = [mapViewController getTabBarItemTitle];
        
        UITabBarController *tabBarController = [UITabBarController new];
        NSArray *viewControllerArray = @[navigationController, mapViewController];
        tabBarController.viewControllers = viewControllerArray;
        tabBarController.tabBar.translucent = YES;
        tabBarController.tabBar.tintColor = [UIColor whiteColor];
        tabBarController.tabBar.barTintColor = [UIColor blackColor];
        self.tabBarController = tabBarController;
    }
    return self;
}

- (UIViewController *)getRootViewController
{
    return self.tabBarController;
}

- (void)scheduleDrinkRequestFromRandomUser
{
    int randomNumber = arc4random_uniform((int)self.dataManager.users.count);
    User *randomUser = self.dataManager.users[randomNumber];
    [self.pushService scheduleDrinkRequestFromUser:randomUser.displayedName];
}

- (void)showLocationOfUserWithName:(NSString *) userName;
{
    [self.tabBarController setSelectedIndex:1];
    MapViewController *mapViewController = (MapViewController *)self.tabBarController.viewControllers[1];
    [mapViewController displayLocationOfUserWithName:userName];
}


#pragma mark - UNUserNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler
{
    UNNotificationContent *content = response.notification.request.content;
    if (content.userInfo[@"userName"])
    {
        NSString *userName = content.userInfo[@"userName"];
        NSLog(@"%@", userName);
        [self showLocationOfUserWithName:userName];
    }
}

@end
