//
//  BRBUserTableView.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 03/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBUserTableView.h"
#import "ProjectSettings.h"

@implementation BRBUserTableView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCollectionViewForAFrame:frame];
        [self setupTableForAFrame:frame];
    }
    return self;
}


- (void)setupCollectionViewForAFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(BRBFilterCollectionViewEdgeInset, BRBFilterCollectionViewEdgeInset, BRBFilterCollectionViewEdgeInset, BRBFilterCollectionViewEdgeInset);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - (BRBFilterCollectionViewCellHeight * 4 + BRBFilterCollectionViewEdgeInset * 5)) collectionViewLayout:layout];
    [self.collectionView setBackgroundColor:[UIColor BRBCollectionViewBackgroundColor]];
    [self addSubview:self.collectionView];
    
}


- (void)setupTableForAFrame:(CGRect)frame
{
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, BRBFilterCollectionViewCellHeight * 4 + BRBFilterCollectionViewEdgeInset * 2, frame.size.width, frame.size.height - (BRBFilterCollectionViewCellHeight * 2 + BRBFilterCollectionViewEdgeInset * 2));
    self.tableView.backgroundColor = [UIColor BRBTableViewSelectedBackgroundColor];

    [self addSubview:self.tableView];
}

@end
