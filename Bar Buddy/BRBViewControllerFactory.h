//
//  ViewControllerFactory.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 01/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRBDataContainer.h"

typedef NS_ENUM(NSInteger, BRBViewControllerType) {
    BRBViewControllerTypeUserTableView,
    BRBViewControllerTypeUserMap
};


@protocol BRBViewControllerFactoryProtocol

@required
- (instancetype)initWithDataContainer:(BRBDataContainer *)dataContainer;
- (NSString *)getTabBarItemTitle;

@end


@interface BRBViewControllerFactory : UIViewController <BRBViewControllerFactoryProtocol>

+ (instancetype)initWithDataContainer:(BRBDataContainer *)dataContainer type:(BRBViewControllerType)viewControllerType;


@end
