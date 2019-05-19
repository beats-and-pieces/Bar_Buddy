//
//  BRBFilterCollectionViewCell.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 15/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRBFilterCollectionViewCell : UICollectionViewCell

//@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
//@property (nonatomic) BOOL isSelected;
@property (nonatomic) BOOL isPressed;


- (void)changeState;

@end

NS_ASSUME_NONNULL_END
