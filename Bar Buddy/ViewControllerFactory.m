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

- (instancetype)initWithDataManager:(DataManager *)dataManager type:(ViewControllerType)viewControllerType
{
    self = nil;
    if (viewControllerType == ViewControllerUserTableViewType)
    {
        self = [[UserTableViewController alloc] initWithDataManager:dataManager];
    }
    else if (viewControllerType == ViewControllerUserMapType)
    {
        self = [[MapViewController alloc] initWithDataManager:dataManager];
    }
    return self;
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


