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
#import "PushService.h"

@interface AppDelegate ()

@property (strong, nonatomic) Assembly *assembly;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    Assembly *assembly = [Assembly new];
    self.assembly = assembly;
    self.persistentContainer = [assembly createPersistentContainer];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = [assembly createRootViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self.assembly sheduleLocalNotification];
}

@end
