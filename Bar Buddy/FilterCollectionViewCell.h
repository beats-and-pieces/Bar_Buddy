//
//  FilterCollectionViewCell.h
//  Flickr_ObjC
//
//  Created by Anton Kuznetsov on 15/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilterCollectionViewCell : UICollectionViewCell

//@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nameLabel;

- (void)changeState;

@end

NS_ASSUME_NONNULL_END
