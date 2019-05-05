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

typedef NS_ENUM(NSInteger, LCTTriggerType) {
    LCTTriggerTypeInterval = 0
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

- (void)sheduleLocalNotification
{
   
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    
    NSArray *requests = @[@"puppies", @"kittens"];
    
    NSDictionary *bodies = @{
                                 requests[0] : @"Вы давно не смотрели щенят",
                                 requests[1] : @"Вы давно не смотрели котят"
                                 };
    content.title = @"Напоминание!";
    int randomNumber = arc4random_uniform(2);
    NSLog(@"random %d", randomNumber);
    content.body = bodies[requests[randomNumber]];
    content.sound = [UNNotificationSound defaultSound];
    NSDictionary *dict = @{
                           @"request": requests[randomNumber]
                           };
    content.userInfo = dict;
    
    // Смотрим разные варианты триггеров
    UNNotificationTrigger *whateverTrigger = [self triggerWithType:LCTTriggerTypeInterval];
    
    // Создаем запрос на выполнение
    // Objective-C
    NSString *identifier = @"NotificationId";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                          content:content trigger:whateverTrigger];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error)
     {
         if (error)
         {
             NSLog(@"Чот пошло не так... %@",error);
         }
     }];
}


#pragma mark - Notifications

- (UNNotificationTrigger *)triggerWithType:(LCTTriggerType)triggerType
{
    switch (triggerType)
    {
        case LCTTriggerTypeInterval:
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