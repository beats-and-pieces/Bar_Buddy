//
//  ViewControllerFactory.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 01/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

//Here we are creating an enum with only two possible values
typedef NS_ENUM(NSInteger, ViewControllerType) {
    UserTableViewType,
    MapType
};

@protocol ViewControllerFactoryProtocol

@required
- (id)initWithDataManager:(DataManager *)dataManager;

@end

@interface ViewControllerFactory : UIViewController <ViewControllerFactoryProtocol>

- (instancetype)initWithDataManager:(DataManager *)dataManager type:(ViewControllerType)viewControllerType;
- (NSString *)getTabBarItemTitle;

@end
