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

@property (nonatomic, strong) UILabel *label;
@property (nonatomic) BOOL isPressed;

@end

NS_ASSUME_NONNULL_END
