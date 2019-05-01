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

//We are defining a Protocol with 2 required methods that must be implemented by any class which wants to handle data storage
@protocol ViewControllerFactoryProtocol

@required
- (id)initWithDataManager:(DataManager *)dataManager;

@end

@interface ViewControllerFactory : UIViewController <ViewControllerFactoryProtocol>

- (instancetype)initWithDataManager:(DataManager *)dataManager type:(ViewControllerType)viewControllerType;
- (NSString *)getTabBarItemTitle;

@end
