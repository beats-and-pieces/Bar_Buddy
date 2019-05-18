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
CGFloat const FilterCollectionViewEdgeInset = 15.0;
CGFloat const FilterCollectionViewCellLabelHeight = 30.0;
CGFloat const FilterCollectionViewCellHeight = 32.0;
CGFloat const FilterCollectionViewCellLabelInset = 8;

NSString *const BarBuddyAPIURL = @"http://private-4df08-barbuddy.apiary-mock.com/users";

// Настройки названий для табов
NSString *const UserTableViewTabBarItemTitle = @"Список пользователей";
NSString *const MapViewTabBarItemTitle = @"На карте";

// Настройки названия для навигейшна
NSString *const UserTableViewNavigationTitle = @"Пользователи";

NSString *const PlaceholderFilename = @"placeholder.png";

CGFloat const BRBZoomLocationLatitude = 55.741476;
CGFloat const BRBZoomLocationLongitude= 37.531409;

CGFloat const BRBZoomArea = 7000;


NSString *const BRBNotificationRequestIdentifier = @"NotificationId";

NSTimeInterval const BRBNotificationTriggerTimeInterval = 5;
