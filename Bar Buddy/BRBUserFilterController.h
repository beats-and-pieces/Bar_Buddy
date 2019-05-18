//
//  BRBUserFilterController.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 18/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataManager;

NS_ASSUME_NONNULL_BEGIN

@interface BRBUserFilterController : UIViewController

- (instancetype)initWithDataManager:(DataManager *)dataManager withFrame:(CGRect)frame;

- (UIView *)getUserFilterView;

@end

NS_ASSUME_NONNULL_END
