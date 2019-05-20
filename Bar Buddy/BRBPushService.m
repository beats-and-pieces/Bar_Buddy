//
//  BRBPushService.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 19/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//


#import "BRBPushService.h"
#import "AppDelegate.h"
#include <stdlib.h>
@import UserNotifications;
#include "ProjectSettings.h"

@interface BRBPushService () <UNUserNotificationCenterDelegate>

@property (nonatomic, nullable) NSError *error;

@end


@implementation BRBPushService

- (instancetype)initForNotificationDelegate:(id<UNUserNotificationCenterDelegate>)delegate
{
    self = [super init];
    if (self) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNAuthorizationOptions options = UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
        center.delegate = delegate;
        [center requestAuthorizationWithOptions:options
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              }];
    }
    return self;
}


- (NSError *)scheduleDrinkRequestFromUser:(NSString *)userName
{
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = userName;
    content.body = BRBNotificationRequestContentBody;
    content.sound = [UNNotificationSound defaultSound];
    
    NSDictionary *dict = @{
                           @"userName": userName
                           };
    content.userInfo = dict;
    
    [self scheduleLocalNotificationWithContent:content];
    return self.error;
}


- (void)scheduleLocalNotificationWithContent:(UNMutableNotificationContent *)content
{
    self.error = nil;
    UNNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:BRBNotificationTriggerTimeInterval repeats:NO];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:BRBNotificationRequestIdentifier content:content trigger:trigger];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error)
     {
         if (error)
         {
             self.error = error;
         }
     }];
}

@end
