//
//  BRBPushService.m
//  Flickr_ObjC
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

@end


@implementation BRBPushService

- (instancetype)initForNotificationDelegate:(id<UNUserNotificationCenterDelegate>)delegate
{
    self = [super init];
    if (self) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = delegate;
        
        // Указываем тип пушей для работы
        UNAuthorizationOptions options = UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
        
        // Запрашиваем доступ на работу с пушами
        [center requestAuthorizationWithOptions:options
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              }];
    }
    return self;
}


- (void)scheduleDrinkRequestFromUser:(NSString *)userName
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
}


- (void)scheduleLocalNotificationWithContent:(UNMutableNotificationContent *)content
{
    UNNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:BRBNotificationTriggerTimeInterval repeats:NO];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:BRBNotificationRequestIdentifier content:content trigger:trigger];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:nil];
}

@end
