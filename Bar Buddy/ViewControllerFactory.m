//
//  ViewControllerFactory.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 01/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "ViewControllerFactory.h"
#import "UserTableViewController.h"
#import "MapViewController.h"


@implementation ViewControllerFactory

+ (instancetype)initWithDataManager:(DataManager *)dataManager type:(ViewControllerType)viewControllerType
{
    switch (viewControllerType) {
        case ViewControllerUserTableViewType:
        {
            return [[UserTableViewController alloc] initWithDataManager:dataManager];
            break;
        }
        case ViewControllerUserMapType:
        {
            return [[MapViewController alloc] initWithDataManager:dataManager];
            break;
        }
        default:
            break;
    }
}


//Убеждаемся, что оба метода должны быть реализованы подклассами

- (instancetype)initWithDataManager:(DataManager *)dataManager
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


