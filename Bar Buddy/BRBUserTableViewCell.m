//
//  BRBUserTableViewCell.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBUserTableViewCell.h"
#import "ProjectSettings.h"

@implementation BRBUserTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _userpicImageView = [UIImageView new];
        _userpicImageView.contentMode = UIViewContentModeScaleAspectFit;
        _userpicImageView.layer.masksToBounds = YES;
        _userpicImageView.layer.cornerRadius = BRBUserpicRoundRadius;
        [self.contentView addSubview:_userpicImageView];
        
        _usernameLabel = [UILabel new];
        _usernameLabel.numberOfLines = 0;
        _usernameLabel.textAlignment = NSTextAlignmentCenter;
        _usernameLabel.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_usernameLabel];
                
        _drinkAndTopicLabel = [UILabel new];
        _drinkAndTopicLabel.numberOfLines = 0;
        _drinkAndTopicLabel.textAlignment = NSTextAlignmentCenter;
        _drinkAndTopicLabel.font = [UIFont systemFontOfSize:40];
        [self.contentView addSubview:_drinkAndTopicLabel];
        
        UIColor *borderColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
        _isDrinkingLabel = [UILabel new];
        _isDrinkingLabel.numberOfLines = 0;
        _isDrinkingLabel.textAlignment = NSTextAlignmentCenter;
        _isDrinkingLabel.font = [UIFont systemFontOfSize:15];
        _isDrinkingLabel.layer.borderColor = borderColor.CGColor;
        _isDrinkingLabel.layer.borderWidth = 1.0;
        _isDrinkingLabel.layer.masksToBounds = YES;
        _isDrinkingLabel.layer.cornerRadius = BRBUserpicRoundRadius;
        [self.contentView addSubview:_isDrinkingLabel];
        
        self.contentView.layer.borderWidth = 2.0;
        self.contentView.layer.borderColor = borderColor.CGColor;
        self.contentView.layer.cornerRadius = BRBUserpicRoundRadius;
        self.contentView.backgroundColor = [UIColor BRBTableViewCellContentViewBackgroungColor];
        
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.layer.cornerRadius = BRBUserpicRoundRadius;
        bgColorView.backgroundColor = [UIColor BRBTableViewCellContentViewBackgroungColor];
        [self setSelectedBackgroundView:bgColorView];
        [self setupConstrains];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self addCellAnimation];
}


- (void)setupConstrains
{
    CGFloat imageSize = (self.contentView.bounds.size.width - BRBUserCellInsets * 3) / 2;
    self.userpicImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.userpicImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant: BRBUserCellInsets].active = YES;
    [self.userpicImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant: BRBUserCellInsets].active = YES;
    [self.userpicImageView.widthAnchor constraintEqualToConstant:imageSize].active = YES;
    [self.userpicImageView.heightAnchor constraintEqualToConstant:imageSize].active = YES;
    [self.userpicImageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant: -1 * BRBUserCellInsets].active = YES;
    
    self.usernameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.usernameLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:BRBUserCellInsets].active = YES;
    [self.usernameLabel.leadingAnchor constraintEqualToAnchor:self.userpicImageView.trailingAnchor constant:BRBUserCellInsets].active = YES;
    [self.usernameLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-1 * BRBUserCellInsets].active = YES;
    
    self.isDrinkingLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.isDrinkingLabel.topAnchor constraintEqualToAnchor:self.drinkAndTopicLabel.bottomAnchor constant:BRBUserCellInsets].active = YES;
    [self.isDrinkingLabel.leadingAnchor constraintEqualToAnchor:self.userpicImageView.trailingAnchor constant:BRBUserCellInsets].active = YES;
    [self.isDrinkingLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-1 * BRBUserCellInsets].active = YES;
    [self.isDrinkingLabel.heightAnchor constraintEqualToConstant: 30.0].active = YES;

    self.drinkAndTopicLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.drinkAndTopicLabel.leadingAnchor constraintEqualToAnchor:self.userpicImageView.trailingAnchor constant:BRBUserCellInsets].active = YES;
    [self.drinkAndTopicLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant: -1 * BRBUserCellInsets].active = YES;
    [self.drinkAndTopicLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
}


-(void)addCellAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[ @0, @10, @-10, @10, @0 ];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = 0.4;
    animation.additive = YES;
    animation.removedOnCompletion = YES;
    [self.layer addAnimation:animation forKey:@"shake"];
}

@end
