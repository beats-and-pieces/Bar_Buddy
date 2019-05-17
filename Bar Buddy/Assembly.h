//
//  Assembly.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 01/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSPersistentContainer;

@interface Assembly : NSObject

- (UIViewController *)getRootViewController;
- (void)switchToMap;
- (void)scheduleLocalNotification;

@end

