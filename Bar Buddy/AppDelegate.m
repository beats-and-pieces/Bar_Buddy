//
//  AppDelegate.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "AppDelegate.h"
#import "Assembly.h"
@import UserNotifications;

@interface AppDelegate ()

@property (strong, nonatomic) Assembly *assembly;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    Assembly *assembly = ;
    self.assembly = [Assembly new];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = [self.assembly getRootViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    [self.assembly scheduleLocalNotification];
}

@end
