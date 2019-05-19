//
//  BRBUserTableViewCell.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRBUserTableViewCell : UITableViewCell

@property (nonatomic, nonnull, strong) UIImageView *userpicImageView;
@property (nonatomic, nonnull, strong) UILabel *usernameLabel;
@property (nonatomic, nonnull, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

NS_ASSUME_NONNULL_END
