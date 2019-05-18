//
//  PushService.m
//  Flickr_ObjC
//
//  Created by Anton Kuznetsov on 19/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//


#import "PushService.h"
#import "AppDelegate.h"
#include <stdlib.h>
@import UserNotifications;
//#import "User+CoreDataClass.h"

typedef NS_ENUM(NSInteger, BRBTriggerType) {
    BRBTriggerTypeInterval = 0
};

@interface PushService () <UNUserNotificationCenterDelegate>

@end

@implementation PushService

- (instancetype)initForNotificationDelegate:(id<UNUserNotificationCenterDelegate>)delegate

{
    self = [super init];
    if (self) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = delegate;
        
        // Указываем тип пушей для работы
        UNAuthorizationOptions options = UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge;
        
        // Запрашиваем доступ на работу с пушами
        [center requestAuthorizationWithOptions:options
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (!granted)
                                  {
                                      NSLog(@"Доступ не дали");
                                  }
                              }];
    }
    return self;
}

- (void)scheduleDrinkRequestFromUser:(NSString *)userName
{
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = userName;
    content.body = @"Вам пришел дринк-реквест!";
    content.sound = [UNNotificationSound defaultSound];

    NSDictionary *dict = @{
                           @"userName": userName
                           };
    content.userInfo = dict;
    
    [self scheduleLocalNotificationWithContent:content];
}

- (void)scheduleLocalNotificationWithContent:(UNMutableNotificationContent *)content
{
    UNNotificationTrigger *trigger = [self triggerWithType:BRBTriggerTypeInterval];
    
    // Создаем запрос на выполнение
    NSString *identifier = @"NotificationId";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                          content:content trigger:trigger];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error)
     {
         if (error)
         {
             NSLog(@"Ошибка отправки пуша %@",error);
         }
     }];
}


#pragma mark - Notifications

- (UNNotificationTrigger *)triggerWithType:(BRBTriggerType)triggerType
{
    switch (triggerType)
    {
        case BRBTriggerTypeInterval:
            return [self intervalTrigger];
        default:
            break;
    }
    return nil;
}

- (UNTimeIntervalNotificationTrigger *)intervalTrigger
{
    return [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
}

@end
