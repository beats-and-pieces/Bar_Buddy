//
//  BRBUserFilterController.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 18/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BRBDataContainer;

NS_ASSUME_NONNULL_BEGIN

@interface BRBUserFilterViewController : UIViewController

- (instancetype)initWithDataManager:(BRBDataContainer *)dataManager withFrame:(CGRect)frame;

- (UIView *)getUserFilterView;

@end

NS_ASSUME_NONNULL_END
