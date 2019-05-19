//
//  Assembly.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 01/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBAssembly.h"
#import "BRBViewControllerFactory.h"
#import "BRBCoreDataStack.h"
#import "BRBPushService.h"
#import "BRBMapViewController.h"

@implementation UIColor (Extensions)

+ (UIColor *)BRBActiveFilterButtonColor
{
    return [UIColor colorWithRed:110.0/255 green:145.0/255 blue:11.0/255 alpha: 1.0];
}

@end

@interface BRBAssembly () <UNUserNotificationCenterDelegate>

@property (nonatomic, nonnull) UITabBarController *tabBarController;
@property (nonatomic, nonnull) BRBPushService *pushService;
@property (nonatomic, nonnull) BRBDataContainer *dataContainer;

@end


@implementation BRBAssembly

- (instancetype)init
{
    self = [super init];
    if (self) {
        BRBPushService *pushService = [[BRBPushService alloc] initForNotificationDelegate:self];
        self.pushService = pushService;
        
        BRBCoreDataStack *coreDataStack = [BRBCoreDataStack new];
        BRBCoreDataService *coreDataService = [[BRBCoreDataService alloc] initWithCoreDataStack:coreDataStack];
        
        BRBNetworkService *netWorkService = [BRBNetworkService new];
        
        BRBDataContainer *dataContainer = [[BRBDataContainer alloc] initWithCoreDataService:coreDataService withNetworkService:netWorkService];
        self.dataContainer = dataContainer;
        
        BRBViewControllerFactory *userTableViewController = [BRBViewControllerFactory initWithDataContainer:dataContainer type:BRBViewControllerTypeUserTableView];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:userTableViewController];
        navigationController.tabBarItem.title = [userTableViewController getTabBarItemTitle];
        
        BRBViewControllerFactory *mapViewController = [BRBViewControllerFactory initWithDataContainer:dataContainer type:BRBViewControllerTypeUserMap];
        mapViewController.tabBarItem.title = [mapViewController getTabBarItemTitle];
        
        UITabBarController *tabBarController = [UITabBarController new];
        NSArray *viewControllerArray = @[navigationController, mapViewController];
        tabBarController.viewControllers = viewControllerArray;
        tabBarController.tabBar.translucent = YES;
        tabBarController.tabBar.tintColor = [UIColor colorWithRed:110.0/255 green:145.0/255 blue:201.0/255 alpha: 1.0];
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
    int randomNumber = arc4random_uniform((int)self.dataContainer.users.count);
    User *randomUser = self.dataContainer.users[randomNumber];
    [self.pushService scheduleDrinkRequestFromUser:randomUser.displayedName];
}


- (void)showLocationOfUserWithName:(NSString *) userName;
{
    [self.tabBarController setSelectedIndex:1];
    BRBMapViewController *mapViewController = (BRBMapViewController *)self.tabBarController.viewControllers[1];
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
