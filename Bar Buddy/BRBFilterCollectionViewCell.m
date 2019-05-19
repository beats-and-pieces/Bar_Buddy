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
        _label.text = @"Test";
        _isPressed = NO;
        self.backgroundColor = [UIColor colorWithRed:110.0/255 green:145.0/255 blue:201.0/255 alpha: 1.0];
        
        [self addSubview:_label];
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8.0f;
        
    }
    return self;
}

@end
