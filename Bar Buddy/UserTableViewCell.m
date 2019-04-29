//
//  UserTableViewCell.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "UserTableViewCell.h"





@interface UserTableViewCell()
@property (nonatomic, strong) NSLayoutConstraint *topCoverImageConstraintY;
@property (nonatomic, strong) NSLayoutConstraint *topCoverImageConstraintX;
@property (nonatomic, strong) NSLayoutConstraint *topCoverImageConstraintWidth;
@property (nonatomic, strong) NSLayoutConstraint *topCoverImageConstraintHeight;


@end
@implementation UserTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _coverImageView = [UIImageView new];
        [self.contentView addSubview:_coverImageView];
        
        _titleLabel = [UILabel new];
        [self.contentView addSubview:_titleLabel];
        
        _descriptionLabel = [UILabel new];
        _descriptionLabel.numberOfLines = 0;
        [self.contentView addSubview:_descriptionLabel];
        
        UITapGestureRecognizer *tapOnCell = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (didTapCell:)];
        [self.contentView addGestureRecognizer:tapOnCell];
        
        [self createGradientLayer];
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
    self.coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.topCoverImageConstraintY = [self.coverImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:16.0];
    self.topCoverImageConstraintY.active = YES;
    
    [self.coverImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16.0].active = YES;
    
    self.topCoverImageConstraintWidth = [self.coverImageView.widthAnchor constraintEqualToConstant:40];
    self.topCoverImageConstraintHeight = [self.coverImageView.heightAnchor constraintEqualToConstant:40];
    
    [NSLayoutConstraint activateConstraints:@[self.topCoverImageConstraintY, self.topCoverImageConstraintWidth, self.topCoverImageConstraintHeight]];
    
    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:16.0].active = YES;
    [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.coverImageView.trailingAnchor constant:16.0].active = YES;
    [self.titleLabel.heightAnchor constraintEqualToConstant:16.0].active = YES;
    [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16.0].active = YES;
    
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.descriptionLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:16.0].active = YES;
    [self.descriptionLabel.leadingAnchor constraintEqualToAnchor:self.coverImageView.trailingAnchor constant:16.0].active = YES;
    [self.descriptionLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16.0].active = YES;
    [self.descriptionLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-16.0].active = YES;
}

-(void)animatePictireDown
{
    self.topCoverImageConstraintY.constant = self.topCoverImageConstraintY.constant + 32.0;
    [self.contentView removeConstraint:self.topCoverImageConstraintY];
    NSLayoutConstraint *alignCenterYConstraint = [self.coverImageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor];
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


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
