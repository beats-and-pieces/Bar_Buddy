//
//  ViewControllerFactory.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 01/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

typedef NS_ENUM(NSInteger, BRBViewControllerType) {
    BRBViewControllerTypeUserTableView,
    BRBViewControllerTypeUserMap
};

@protocol ViewControllerFactoryProtocol

@required
- (instancetype)initWithDataManager:(DataManager *)dataManager;
- (NSString *)getTabBarItemTitle;

@end

@interface ViewControllerFactory : UIViewController <ViewControllerFactoryProtocol>

+ (instancetype)initWithDataManager:(DataManager *)dataManager type:(BRBViewControllerType)viewControllerType;


@end
