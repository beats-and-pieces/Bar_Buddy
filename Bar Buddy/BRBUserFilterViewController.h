//
//  BRBUserFilterController.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 18/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BRBDataContainer;
#import "BRBUserFilterView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BRBUserFilterViewController : UIViewController

- (instancetype)initWithDataContainer:(BRBDataContainer *)dataContainer;

- (UIView *)getUserFilterView;

@property (nonatomic, strong) BRBUserFilterView *userFilterView;

@end

NS_ASSUME_NONNULL_END
