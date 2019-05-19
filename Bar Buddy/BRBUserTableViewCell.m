//
//  BRBUserTableViewCell.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBUserTableViewCell.h"
#import "ProjectSettings.h"

@interface BRBUserTableViewCell()
@property (nonatomic, strong) NSLayoutConstraint *topCoverImageConstraintY;
@property (nonatomic, strong) NSLayoutConstraint *topCoverImageConstraintX;

@property (nonatomic, strong) NSLayoutConstraint *topCoverImageConstraintWidth;
@property (nonatomic, strong) NSLayoutConstraint *topCoverImageConstraintHeight;


@end
@implementation BRBUserTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    //    my
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
        
        _drinkLabel = [UILabel new];
        _drinkLabel.numberOfLines = 0;
        _topicLabel = [UILabel new];
        _topicLabel.numberOfLines = 0;
        //        [self.contentView addSubview:_drinkLabel];
        //        [self.contentView addSubview:_topicLabel];
        
        _drinkAndTopicLabel = [UILabel new];
        _drinkAndTopicLabel.numberOfLines = 0;
        _drinkAndTopicLabel.textAlignment = NSTextAlignmentCenter;
        _drinkAndTopicLabel.font = [UIFont systemFontOfSize:40];
        [self.contentView addSubview:_drinkAndTopicLabel];
        
        //
//        _isDrinkingLabel = [UILabel new];
//        _isDrinkingLabel.numberOfLines = 0;
//        _isDrinkingLabel.textAlignment = NSTextAlignmentCenter;
//        _isDrinkingLabel.font = [UIFont systemFontOfSize:15];
//        [self.contentView addSubview:_isDrinkingLabel];
//        UIColor *borderColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
//        _isDrinkingLabel.layer.borderColor = borderColor.CGColor;
//        _isDrinkingLabel.layer.borderWidth = 3.0;
        
        _isDrinkingLabel = [UIButton new];
//        _isDrinkingLabel.numberOfLines = 0;
        _isDrinkingLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
        _isDrinkingLabel.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_isDrinkingLabel];
        UIColor *borderColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
        _isDrinkingLabel.layer.borderColor = borderColor.CGColor;
        _isDrinkingLabel.layer.borderWidth = 3.0;
        
        _isDrinkingLabel.layer.masksToBounds = YES;
        _isDrinkingLabel.layer.cornerRadius = BRBUserpicRoundRadius;
        
        [self.contentView addSubview:_isDrinkingLabel];
        
        self.contentView.layer.borderWidth = 1.0;
        self.contentView.layer.borderColor = borderColor.CGColor;
        self.contentView.layer.cornerRadius = BRBUserpicRoundRadius;
        self.contentView.backgroundColor = [UIColor colorWithRed:186.9/255 green:217.0/255 blue:239.0/255 alpha: 1.0];
        
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.layer.cornerRadius = BRBUserpicRoundRadius;
        bgColorView.backgroundColor = [UIColor colorWithRed:110.0/255 green:145.0/255 blue:201.0/255 alpha: 1.0];
        [self setSelectedBackgroundView:bgColorView];
        [self setupConstrains];
    }
    
    return self;
}

- (void)layoutSubviews
{
    self.gradientLayer.frame = self.contentView.bounds;
    [super layoutSubviews];
    [self addCellAnimation];
    
}

- (void)setupConstrains
{
    self.userpicImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.topCoverImageConstraintY = [self.userpicImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant: BRBUserCellInsets];
    self.topCoverImageConstraintY.active = YES;
    
    [self.userpicImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant: BRBUserCellInsets].active = YES;
    
    CGFloat imageSize = (self.contentView.bounds.size.width - BRBUserCellInsets * 3) / 2;
    self.topCoverImageConstraintWidth = [self.userpicImageView.widthAnchor constraintEqualToConstant:imageSize];
    self.topCoverImageConstraintHeight = [self.userpicImageView.heightAnchor constraintEqualToConstant:imageSize];
    //    self.bo
    NSLayoutConstraint *bottomImageConstraint = [self.userpicImageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant: -1 * BRBUserCellInsets];
    [NSLayoutConstraint activateConstraints:@[self.topCoverImageConstraintY, self.topCoverImageConstraintWidth, self.topCoverImageConstraintHeight, bottomImageConstraint]];
    
    
    self.usernameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.usernameLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:BRBUserCellInsets].active = YES;
    [self.usernameLabel.leadingAnchor constraintEqualToAnchor:self.userpicImageView.trailingAnchor constant:BRBUserCellInsets].active = YES;
    //    [self.usernameLabel.heightAnchor constraintEqualToConstant:16.0].active = YES;
    [self.usernameLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-1 * BRBUserCellInsets].active = YES;
    
    self.isDrinkingLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.isDrinkingLabel.topAnchor constraintEqualToAnchor:self.drinkAndTopicLabel.bottomAnchor constant:BRBUserCellInsets].active = YES;
    [self.isDrinkingLabel.leadingAnchor constraintEqualToAnchor:self.userpicImageView.trailingAnchor constant:BRBUserCellInsets].active = YES;
    //    [self.usernameLabel.heightAnchor constraintEqualToConstant:16.0].active = YES;
    [self.isDrinkingLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-1 * BRBUserCellInsets].active = YES;
    [self.isDrinkingLabel.heightAnchor constraintEqualToConstant: 30.0].active = YES;
    
    //    self.drinkLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //    [self.drinkLabel.topAnchor constraintEqualToAnchor:self.usernameLabel.bottomAnchor constant:16.0].active = YES;
    //    [self.drinkLabel.leadingAnchor constraintEqualToAnchor:self.userpicImageView.trailingAnchor constant:16.0].active = YES;
    //    [self.drinkLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16.0].active = YES;
    //    [self.drinkLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-16.0].active = YES;
    //
    //    self.topicLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //    [self.topicLabel.topAnchor constraintEqualToAnchor:self.usernameLabel.bottomAnchor constant:16.0].active = YES;
    //    [self.topicLabel.leadingAnchor constraintEqualToAnchor:self.userpicImageView.trailingAnchor constant:40.0].active = YES;
    //    [self.topicLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16.0].active = YES;
    //    [self.topicLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-16.0].active = YES;
    //
    self.drinkAndTopicLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //    [self.drinkAndTopicLabel.topAnchor constraintEqualToAnchor:self.usernameLabel.bottomAnchor constant:16.0].active = YES;
    [self.drinkAndTopicLabel.leadingAnchor constraintEqualToAnchor:self.userpicImageView.trailingAnchor constant:BRBUserCellInsets].active = YES;
    [self.drinkAndTopicLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant: -1 * BRBUserCellInsets].active = YES;
    //    [self.drinkAndTopicLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-16.0].active = YES;
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

//Добавляем анимацию к нажатию
-(void)didTapCell: (UITapGestureRecognizer *)recognizer
{
    [self addCellAnimation];
}


-(void)createGradientLayer
{
    UIColor *topColor = [UIColor colorWithRed:100.0/255.0 green:250.0/255.0 blue:50.0/255.0 alpha:0.5];
    UIColor *bottomColor = [UIColor colorWithRed:100.0/255.0 green:200.0/255.0 blue:100.0/255.0 alpha:1.0];
    UIColor *borderColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    // Создаём градиент
    CAGradientLayer *theViewGradient = [CAGradientLayer layer];
    theViewGradient.colors = [NSArray arrayWithObjects: (id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    theViewGradient.frame = self.contentView.bounds;
    theViewGradient.borderWidth = 3;
    theViewGradient.borderColor = borderColor.CGColor;
    self.gradientLayer = theViewGradient;
    //Добавляем градиент к слою
    [self.contentView.layer insertSublayer:theViewGradient atIndex:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
