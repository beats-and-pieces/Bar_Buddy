//
//  ProjectSettings.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 05/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const BRBUserpicRoundRadius;
extern CGFloat const BRBUserCellInsets;
extern  CGFloat const BRBCollectionViewCellRoundRadius;
extern CGFloat const BRBFilterCollectionViewEdgeInset;
extern CGFloat const BRBFilterCollectionViewCellLabelHeight;
extern CGFloat const BRBFilterCollectionViewCellHeight;
extern CGFloat const BRBFilterCollectionViewCellLabelInset;

extern NSString *const BRBBarBuddyAPIURL;

extern NSString *const BRBUserTableViewTabBarItemTitle;
extern NSString *const BRBMapViewTabBarItemTitle;
extern NSString *const BRBUserTableViewNavigationTitle;

extern NSString *const BRBPlaceholderFilename;

extern CGFloat const BRBZoomLocationLatitude;
extern CGFloat const BRBZoomLocationLongitude;

extern CGFloat const BRBZoomArea;

extern NSString *const BRBNotificationRequestIdentifier;

extern NSTimeInterval const BRBNotificationTriggerTimeInterval;

extern UIColor *  const COLOR_LIGHT_BLUE;


@interface UIColor (BRBProject)

+ (UIColor *) BRBTableViewSelectedBackgroundColor;
+ (UIColor *) BRBCollectionViewBackgroundColor;
+ (UIColor *) BRBBorderColor;
+ (UIColor *) BRBTableViewCellContentViewBackgroungColor;
+ (UIColor *) BRBTableViewCellBackgroungColor;
+ (UIColor *) BRBCollectionViewCellBackgroungColor;
+ (UIColor *) BRBCollectionViewCellSelectedColor;
+ (UIColor *) BRBTabBarTintColor;

@end
