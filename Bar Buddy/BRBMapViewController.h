//
//  MapViewController.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRBViewControllerFactory.h"

@interface BRBMapViewController : BRBViewControllerFactory

- (instancetype)initWithDataManager:(BRBDataContainer *)dataManager;
- (NSString *)getTabBarItemTitle;
- (void)displayLocationOfUserWithName:(NSString *)userName;

@end
