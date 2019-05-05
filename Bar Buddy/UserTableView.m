//
//  UserTableView.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 03/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "UserTableView.h"
#import "ProjectSettings.h"

@implementation UserTableView


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
    //    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 30);
    //    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewIdentifier"];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - (32 * 2 + FilterCollectionViewEdgeInset * 2)) collectionViewLayout:layout];
    layout.sectionInset = UIEdgeInsetsMake(FilterCollectionViewEdgeInset, FilterCollectionViewEdgeInset, FilterCollectionViewEdgeInset, FilterCollectionViewEdgeInset);
    
    [self.collectionView setBackgroundColor:[UIColor colorWithRed: 143.0/255.0 green:174.0/255 blue:224.0/255 alpha: 1.0]];
    
    [self addSubview:self.collectionView];
    
}

- (void)setupTableForAFrame:(CGRect)frame
{
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 32 * 2 + FilterCollectionViewEdgeInset * 2, frame.size.width, frame.size.height - 32 * 2 + FilterCollectionViewEdgeInset * 2);
    
    [self addSubview:self.tableView];
}

@end
