//
//  PushService.h
//  Flickr_ObjC
//
//  Created by Anton Kuznetsov on 19/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UserNotifications;

@interface PushService : NSObject

- (void)scheduleLocalNotification;
- (instancetype)initForNotificationDelegate:(id<UNUserNotificationCenterDelegate>)delegate;

@end
