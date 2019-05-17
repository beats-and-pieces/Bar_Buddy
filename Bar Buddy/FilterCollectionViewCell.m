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
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(FilterCollectionViewCellLabelInset, frame.size.height - FilterCollectionViewCellLabelHeight, frame.size.width - FilterCollectionViewCellLabelInset * 2, FilterCollectionViewCellLabelHeight)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        _label.text = @"Test";
        _isPressed = NO;
        self.backgroundColor = [UIColor colorWithRed:110.0/255 green:145.0/255 blue:201.0/255 alpha: 1.0];
        
        //        [self addSubview:_imageView];
        [self addSubview:_label];
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8.0f;
        
    }
    return self;
}

- (void)changeState
{
    if (self.isPressed)
    {
        NSLog(@"Pressed = YES");
        self.isPressed = NO;
//        self.backgroundColor = [UIColor colorWithRed:110.0/255 green:145.0/255 blue:11.0/255 alpha: 1.0];
    }
    else
    {
        NSLog(@"Pressed = NO");
        self.isPressed = YES;
        self.backgroundColor = [UIColor colorWithRed:110.0/255 green:145.0/255 blue:11.0/255 alpha: 1.0];
    }
    
    
    
   // self.label.text = @"Test";
    
}


//- (void)setSelected:(BOOL)selected
//{
//    [super setSelected:selected];
//    NSLog(@"setSelected");
//    
////    if (self.isSelected)
////    {
////        self.backgroundColor = [UIColor colorWithRed:110.0/255 green:145.0/255 blue:201.0/255 alpha: 1.0];
////        self.selected = NO;
////        self.nameLabel.text = @"setUNSelected";
////    }
////    else
////    {
////        
////        self.backgroundColor = [UIColor colorWithRed:110.0/255 green:145.0/255 blue:11.0/255 alpha: 1.0];
////        self.selected = YES;
////    }
//    
//    self.label.text = @"setSelected";
//    self.backgroundColor = [UIColor colorWithRed:110.0/255 green:145.0/255 blue:11.0/255 alpha: 1.0];
//}


@end
