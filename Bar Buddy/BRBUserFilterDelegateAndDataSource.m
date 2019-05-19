//
//  BRBUserFilterDelegateAndDataSource.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 19/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBUserFilterDelegateAndDataSource.h"

#import "BRBDataContainer.h"
#import "BRBFilterCollectionViewCell.h"
#import "ProjectSettings.h"


@interface BRBUserFilterDelegateAndDataSource () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) BRBDataContainer *dataContainer;
@property (nonatomic) NSInteger preferredDrink;
@property (nonatomic) NSInteger preferredTopic;
@property (nonatomic) CGFloat screenWidth;

@end

@implementation BRBUserFilterDelegateAndDataSource

- (instancetype)initWithDataContainer:(BRBDataContainer *)dataContainer
{
    self = [super init];
    if (self) {
        _dataContainer = dataContainer;
    }
    return self;
}

- (void)setWidth:(CGFloat)width
{
    self.screenWidth = width;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BRBFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BRBFilterCollectionViewCell class]) forIndexPath:indexPath];
    
    switch (indexPath.section)
    {
        case 0:
        {
            cell.label.text = self.dataContainer.drinkValues[indexPath.row];
            break;
        }
        case 1:
        {
            cell.label.text = self.dataContainer.topicValues[indexPath.row];
            break;
        }
        default:
            break;
    }
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BRBFilterCollectionViewCell *cell = (id)[collectionView cellForItemAtIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            if (cell.isPressed)
            {
                self.preferredDrink = 0;
            }
            else
            {
                self.preferredDrink = indexPath.row + 1;
            }
            break;
        case 1:
            if (cell.isPressed)
            {
                self.preferredTopic = 0;
            }
            else
            {
                self.preferredTopic = indexPath.row + 1;
            }
            break;
        default:
            break;
    }
    
    [self changeStateOfCell:cell inCollectionView:collectionView forSection:indexPath.section];
    [self.dataContainer updateFilteredResultsWithDrinkType:self.preferredDrink withTopicType:self.preferredTopic];
}


- (NSArray *)collectionView:(UICollectionView *)collectionView visibleCellsInSection:(NSInteger)section
{
    NSPredicate *visibleCellsInSectionPredicate = [NSPredicate predicateWithBlock:^BOOL(BRBFilterCollectionViewCell *visibleCell, NSDictionary *bindings) {
        return [collectionView indexPathForCell:visibleCell].section == section;
    }];
    return [collectionView.visibleCells filteredArrayUsingPredicate:visibleCellsInSectionPredicate];
}


- (void)changeStateOfCell:(BRBFilterCollectionViewCell *)cell inCollectionView:(UICollectionView *)collectionView forSection:(NSInteger)section
{
    if (cell.isPressed)
    {
        cell.isPressed = NO;
        cell.backgroundColor = [UIColor colorWithRed:110.0/255 green:145.0/255 blue:201.0/255 alpha: 1.0];
    } else
    {
        for (BRBFilterCollectionViewCell *visibleCell in [self collectionView:collectionView visibleCellsInSection:section])
        {
            visibleCell.backgroundColor = [UIColor colorWithRed:110.0/255 green:145.0/255 blue:201.0/255 alpha: 1.0];
            visibleCell.isPressed = NO;
        }
        cell.isPressed = YES;
        cell.backgroundColor = [UIColor colorWithRed:36.0/255 green:147.0/255 blue:226.0/255 alpha: 1.0];
    }
}
#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.screenWidth - 5 * BRBFilterCollectionViewEdgeInset ) / 3, BRBFilterCollectionViewCellHeight);
}

@end
