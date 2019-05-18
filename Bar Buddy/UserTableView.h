//
//  UserTableView.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 03/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserTableView : UIView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

- (void)setupCollectionViewForAFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
