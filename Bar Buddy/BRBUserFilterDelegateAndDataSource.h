//
//  BRBUserFilterDelegateAndDataSource.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 19/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BRBDataContainer;

NS_ASSUME_NONNULL_BEGIN

@interface BRBUserFilterDelegateAndDataSource : NSObject

- (instancetype)initWithDataContainer:(BRBDataContainer *)dataContainer;
- (void)setWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
