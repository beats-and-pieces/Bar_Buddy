//
//  ProjectSettings.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 05/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//


#import "ProjectSettings.h"


// Настройки таблицы
CGFloat const BRBUserpicRoundRadius = 16.0;
CGFloat const BRBCollectionViewCellRoundRadius = 8.0;
CGFloat const BRBUserCellInsets = 16.0;

// Настройки фильтрв - колекшн вью
CGFloat const BRBFilterCollectionViewEdgeInset = 15.0;
CGFloat const BRBFilterCollectionViewCellLabelHeight = 30.0;
CGFloat const BRBFilterCollectionViewCellHeight = 32.0;
CGFloat const BRBFilterCollectionViewCellLabelInset = 8;

NSString *const BRBBarBuddyAPIURL = @"http://private-4df08-barbuddy.apiary-mock.com/users";

// Настройки названий для табов
NSString *const BRBUserTableViewTabBarItemTitle = @"Список пользователей";
NSString *const BRBMapViewTabBarItemTitle = @"На карте";

// Настройки названия для навигейшна
NSString *const BRBUserTableViewNavigationTitle = @"Пользователи";

NSString *const BRBPlaceholderFilename = @"placeholder.png";

CGFloat const BRBZoomLocationLatitude = 55.741476;
CGFloat const BRBZoomLocationLongitude= 37.531409;

CGFloat const BRBZoomArea = 7000;



NSString *const BRBNotificationRequestIdentifier = @"NotificationId";

NSTimeInterval const BRBNotificationTriggerTimeInterval = 5;



@implementation UIColor (BRBProject)

+ (UIColor *) BRBTableViewSelectedBackgroundColor { return [UIColor colorWithRed:0.6 green:0.8 blue:1.0 alpha:1.0];}
+ (UIColor *) BRBCollectionViewBackgroundColor { return [UIColor colorWithRed: 143.0/255.0 green:174.0/255 blue:224.0/255 alpha: 1.0];}
+ (UIColor *) BRBBorderColor { return [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];}

+ (UIColor *) BRBTableViewCellContentViewBackgroungColor { return [UIColor colorWithRed:186.9/255 green:217.0/255 blue:239.0/255 alpha: 1.0];}
+ (UIColor *) BRBTableViewCellBackgroungColor { return [UIColor colorWithRed:110.0/255 green:145.0/255 blue:201.0/255 alpha: 1.0];}
+ (UIColor *) BRBCollectionViewCellBackgroungColor { return [UIColor colorWithRed:110.0/255 green:145.0/255 blue:201.0/255 alpha: 1.0];}
+ (UIColor *) BRBCollectionViewCellSelectedColor { return [UIColor colorWithRed:36.0/255 green:147.0/255 blue:226.0/255 alpha: 1.0];}

+ (UIColor *) BRBTabBarTintColor { return [UIColor colorWithRed:110.0/255 green:145.0/255 blue:201.0/255 alpha: 1.0];}



@end



