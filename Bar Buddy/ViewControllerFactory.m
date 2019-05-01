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
//Based on the DataType it is decided if FileStorage or DatabaseStorage class should be instantiated
- (id)initWithDataManager:(DataManager *)dataManager type:(ViewControllerType)viewControllerType
{
    self = nil;
    if (viewControllerType == UserTableViewType)
    {
        self = [[UserTableViewController alloc] initWithDataManager:dataManager];
    }
    else if (viewControllerType == MapType)
    {
        self = [[MapViewController alloc] initWithDataManager:dataManager];
    }
    return self;
}

//- (NSString *)getTabBarItemTitle
//{
//    
//}

//Ensuring below that the saveData and initWithData method must be implemented by the private subclasses

- (id)initWithDataManager:(DataManager *)dataManager {
    [NSException raise:NSInternalInconsistencyException
                format:@"You have not implemented %@ in %@", NSStringFromSelector(_cmd), NSStringFromClass([self class])];
    return nil;
}

@end


