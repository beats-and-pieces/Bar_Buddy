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
//#import "PushService.h"

@interface AppDelegate ()

@property (strong, nonatomic) Assembly *assembly;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    Assembly *assembly = [Assembly new];
    self.assembly = assembly;
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = [assembly getRootViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [self.assembly scheduleLocalNotification];
}

@end
