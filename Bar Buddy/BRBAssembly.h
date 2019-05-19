//
//  Assembly.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 01/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSPersistentContainer;

NS_ASSUME_NONNULL_BEGIN

@interface BRBAssembly : NSObject

- (UIViewController *)getRootViewController;
- (void)scheduleDrinkRequestFromRandomUser;

@end

NS_ASSUME_NONNULL_END

