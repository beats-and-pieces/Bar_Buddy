//
//  Assembly.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 01/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class NSPersistentContainer;

@interface Assembly : NSObject

- (UIViewController *)createRootViewController;
- (NSPersistentContainer *)createPersistentContainer;
- (void)switchToMap;

@end

NS_ASSUME_NONNULL_END
