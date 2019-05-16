//
//  UserTableViewCell.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "UserTableViewCell.h"
#import "ProjectSettings.h"

@interface UserTableViewCell()
@property (nonatomic, strong) NSLayoutConstraint *topCoverImageConstraintY;
@property (nonatomic, strong) NSLayoutConstraint *topCoverImageConstraintX;

@property (nonatomic, strong) NSLayoutConstraint *topCoverImageConstraintWidth;
@property (nonatomic, strong) NSLayoutConstraint *topCoverImageConstraintHeight;


@end
@implementation UserTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
//    my
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _userpicImageView = [UIImageView new];
        _userpicImageView.contentMode = UIViewContentModeScaleAspectFit;
        _userpicImageView.layer.masksToBounds = YES;
        _userpicImageView.layer.cornerRadius = UserpicRoundRadius;
        [self.contentView addSubview:_userpicImageView];
        
        _usernameLabel = [UILabel new];
        [self.contentView addSubview:_usernameLabel];
        
        _descriptionLabel = [UILabel new];
        _descriptionLabel.numberOfLines = 0;
        [self.contentView addSubview:_descriptionLabel];
        
//        UITapGestureRecognizer *tapOnCell = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (didTapCell:)];
//        [self.contentView addGestureRecognizer:tapOnCell];
        
        [self createGradientLayer];
        [self setupConstrains];
    }
    
    return self;
}

- (void)layoutSubviews
{
    self.gradientLayer.frame = self.contentView.bounds;
    [super layoutSubviews];
//    [self addCellAnimation];
    
}

- (void)setupConstrains
{
    self.userpicImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.topCoverImageConstraintY = [self.userpicImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant: UserCellInsets];
    self.topCoverImageConstraintY.active = YES;
    
    [self.userpicImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant: UserCellInsets].active = YES;
    
    CGFloat imageSize = (self.contentView.bounds.size.width - UserCellInsets * 3) / 2;
    self.topCoverImageConstraintWidth = [self.userpicImageView.widthAnchor constraintEqualToConstant:imageSize];
    self.topCoverImageConstraintHeight = [self.userpicImageView.heightAnchor constraintEqualToConstant:imageSize];
//    self.bo
    NSLayoutConstraint *bottomImageConstraint = [self.userpicImageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant: -1 * UserCellInsets];
    [NSLayoutConstraint activateConstraints:@[self.topCoverImageConstraintY, self.topCoverImageConstraintWidth, self.topCoverImageConstraintHeight, bottomImageConstraint]];
    
    
    self.usernameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.usernameLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:16.0].active = YES;
    [self.usernameLabel.leadingAnchor constraintEqualToAnchor:self.userpicImageView.trailingAnchor constant:16.0].active = YES;
    [self.usernameLabel.heightAnchor constraintEqualToConstant:16.0].active = YES;
    [self.usernameLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16.0].active = YES;
    
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.descriptionLabel.topAnchor constraintEqualToAnchor:self.usernameLabel.bottomAnchor constant:16.0].active = YES;
    [self.descriptionLabel.leadingAnchor constraintEqualToAnchor:self.userpicImageView.trailingAnchor constant:16.0].active = YES;
    [self.descriptionLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16.0].active = YES;
    [self.descriptionLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-16.0].active = YES;
}

- (void)animatePictureDown
{
    self.topCoverImageConstraintY.constant = self.topCoverImageConstraintY.constant + 32.0;
    [self.contentView removeConstraint:self.topCoverImageConstraintY];
    NSLayoutConstraint *alignCenterYConstraint = [self.userpicImageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor];
    [self.contentView addConstraint:alignCenterYConstraint];
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
