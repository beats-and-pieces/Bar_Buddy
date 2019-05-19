//
//  BRBUserFilterDelegateAndDataSource.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 19/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBUserFilterDelegateAndDataSource.h"

#import "BRBUserTableViewController.h"
#import "BRBUserTableView.h"
#import "BRBUserTableViewCell.h"
#import "BRBFilterCollectionViewCell.h"
//#import "BRBDataContainerDelegateProtocol.h"
#import "ProjectSettings.h"
#import "BRBAlertController.h"
#import "BRBUserFilterViewController.h"




@interface BRBUserFilterDelegateAndDataSource () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) BRBDataContainer *dataContainer;

@property (nonatomic) NSInteger preferredDrink;
@property (nonatomic) NSInteger preferredCompany;
@property (nonatomic, copy) NSArray<NSString *> *drinkFilterValues;
@property (nonatomic, copy) NSArray<NSString *> *topicFilterValues;
@property (nonatomic) CGFloat screenWidth;

@end

@implementation BRBUserFilterDelegateAndDataSource

- (instancetype)initWithDataContainer:(BRBDataContainer *)dataContainer
{
    self = [super init];
    if (self) {
        _dataContainer = dataContainer;
        _drinkFilterValues = @[@"🍺", @"🍷", @"🥃"];
        _topicFilterValues = @[@"🏎", @"🎼", @"💼"];        
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
            cell.label.text = self.drinkFilterValues[indexPath.row];
            break;
        }
        case 1:
        {
            cell.label.text = self.topicFilterValues[indexPath.row];
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
    BRBFilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BRBFilterCollectionViewCell class]) forIndexPath:indexPath];
    [cell changeState];
    switch (indexPath.section) {
        case 0:
            self.preferredDrink = indexPath.row + 1;
            break;
        case 1:
            self.preferredCompany = indexPath.row + 1;
            break;
        default:
            break;
    }
    [self.dataContainer updateFilteredResultsWithDrinkType:self.preferredDrink withCompanyType:self.preferredCompany];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.screenWidth - 5 * BRBFilterCollectionViewEdgeInset ) / 3, BRBFilterCollectionViewCellHeight);
}

@end
