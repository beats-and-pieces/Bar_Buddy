//
//  MapViewController.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerFactory.h"

@interface MapViewController : ViewControllerFactory

- (instancetype)initWithDataManager:(DataManager *)dataManager;
- (NSString *)getTabBarItemTitle;
- (void)displayLocationOfUserWithName:(NSString *)userName;

@end
