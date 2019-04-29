//
//  UserTableViewCell.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserTableViewCell : UITableViewCell

@property (nonnull, strong) UIImageView *coverImageView;
@property (nonnull, strong) UILabel *titleLabel;
@property (nonnull, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

NS_ASSUME_NONNULL_END
