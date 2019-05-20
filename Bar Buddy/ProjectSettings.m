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



