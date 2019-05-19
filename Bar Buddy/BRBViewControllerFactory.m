//
//  ViewControllerFactory.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 01/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBViewControllerFactory.h"
#import "BRBUserTableViewController.h"
#import "BRBMapViewController.h"


@implementation BRBViewControllerFactory

+ (instancetype)initWithDataManager:(BRBDataContainer *)dataManager type:(BRBViewControllerType)viewControllerType
{
    switch (viewControllerType) {
        case BRBViewControllerTypeUserTableView:
        {
            return [[BRBUserTableViewController alloc] initWithDataManager:dataManager];
            break;
        }
        case BRBViewControllerTypeUserMap:
        {
            return [[BRBMapViewController alloc] initWithDataManager:dataManager];
            break;
        }
        default:
            break;
    }
}


//Убеждаемся, что оба метода должны быть реализованы подклассами

- (instancetype)initWithDataManager:(BRBDataContainer *)dataManager
{
    NSString *description = [NSString stringWithFormat:@"You have not implemented %@ in %@", NSStringFromSelector(_cmd), NSStringFromClass([self class])];
    NSAssert(YES, description);
    return nil;
}

- (NSString *)getTabBarItemTitle
{
    NSString *description = [NSString stringWithFormat:@"You have not implemented %@ in %@", NSStringFromSelector(_cmd), NSStringFromClass([self class])];
    NSAssert(YES, description);
    return nil;
}

@end


