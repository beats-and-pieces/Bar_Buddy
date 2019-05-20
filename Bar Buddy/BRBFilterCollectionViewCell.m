//
//  BRBFilterCollectionViewCell.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 15/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBFilterCollectionViewCell.h"
#import "ProjectSettings.h"

@interface BRBFilterCollectionViewCell ()

@end

@implementation BRBFilterCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(BRBFilterCollectionViewCellLabelInset, frame.size.height - BRBFilterCollectionViewCellLabelHeight, frame.size.width - BRBFilterCollectionViewCellLabelInset * 2, BRBFilterCollectionViewCellLabelHeight)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        _isPressed = NO;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = BRBCollectionViewCellRoundRadius;
        self.backgroundColor = [UIColor BRBCollectionViewCellBackgroungColor];
        
        [self addSubview:_label];
    }
    return self;
}

@end
