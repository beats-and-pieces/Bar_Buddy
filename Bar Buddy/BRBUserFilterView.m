//
//  BRBUserFilterView.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 18/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBUserFilterView.h"
#import "ProjectSettings.h"

@implementation BRBUserFilterView

- (instancetype)initWithFrame:(CGRect)frame
{
//    self = [super initWithFrame:frame];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - (BRBFilterCollectionViewCellHeight * 4 + BRBFilterCollectionViewEdgeInset * 5)) collectionViewLayout:layout];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed: 143.0/255.0 green:174.0/255 blue:224.0/255 alpha: 1.0]];
//        [self setupCollectionViewForAFrame:frame];
    }
    return self;
}

- (void)setupCollectionViewForAFrame:(CGRect)frame
{
    
    //    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 30);
    //    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewIdentifier"];
    
//    self.userFilterView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - (FilterCollectionViewCellHeight * 4 + FilterCollectionViewEdgeInset * 5)) collectionViewLayout:layout];
//    layout.sectionInset = UIEdgeInsetsMake(FilterCollectionViewEdgeInset, FilterCollectionViewEdgeInset, FilterCollectionViewEdgeInset, FilterCollectionViewEdgeInset);
    
    
    //    [self.collectionView setAlpha:0.7];
    
//    [self addSubview:self.collectionView];
    
}

@end
