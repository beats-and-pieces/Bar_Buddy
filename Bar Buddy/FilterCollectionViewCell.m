//
//  FilterCollectionViewCell
//  Flickr_ObjC
//
//  Created by Anton Kuznetsov on 15/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "FilterCollectionViewCell.h"
#import "ProjectSettings.h"

@interface FilterCollectionViewCell ()

@end

@implementation FilterCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        _imageView = [[UIImageView alloc]init];
//        _imageView.frame = CGRectMake(8, 8, frame.size.width - 16, frame.size.height - 30);
//
//        _imageView.contentMode = UIViewContentModeScaleAspectFit;

        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(FilterCollectionViewCellLabelInset, frame.size.height - FilterCollectionViewCellLabelHeight, frame.size.width - FilterCollectionViewCellLabelInset * 2, FilterCollectionViewCellLabelHeight)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.text = @"Test";
        
        self.backgroundColor = [UIColor colorWithRed:110.0/255 green:145.0/255 blue:201.0/255 alpha: 1.0];
    
//        [self addSubview:_imageView];
        [self addSubview:_nameLabel];
    
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8.0f;
    }
    return self;
}





@end
