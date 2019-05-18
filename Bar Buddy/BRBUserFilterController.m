//
//  BRBUserFilterController.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 18/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBUserFilterController.h"
#import "FilterCollectionViewCell.h"
#import "DataManager.h"
#import "BRBUserFilterView.h"
#import "ProjectSettings.h"

@interface BRBUserFilterController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) BRBUserFilterView *userFilterView;
@property (nonatomic, strong) DataManager *dataManager;

@property (nonatomic) NSInteger preferredDrink;
@property (nonatomic) NSInteger preferredCompany;
@property (nonatomic, copy) NSArray<NSString *> *drinkFilterValues;
@property (nonatomic, copy) NSArray<NSString *> *topicFilterValues;

@end

@implementation BRBUserFilterController

- (instancetype)initWithDataManager:(DataManager *)dataManager withFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _dataManager = dataManager;
        _drinkFilterValues = @[@"🍺", @"🍷", @"🥃"];
        _topicFilterValues = @[@"🏎", @"🎼", @"💼"];
         CGRect newFrame = CGRectMake(0, self.navigationController.navigationBar.bounds.size.height, frame.size.width, frame.size.height - self.navigationController.navigationBar.bounds.size.height - self.tabBarController.tabBar.bounds.size.height);
        self.userFilterView = [[BRBUserFilterView alloc] initWithFrame:newFrame];
    }
    return self;
}

- (void)createView
{
    
//    CGRect newFrame = CGRectMake(0, self.navigationController.navigationBar.bounds.size.height, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.bounds.size.height - self.tabBarController.tabBar.bounds.size.height);
//     self.collectionView = userTableView.collectionView;
    
    [self.userFilterView registerClass:[FilterCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([FilterCollectionViewCell class])];
    
    [self.userFilterView setDataSource:self];
    [self.userFilterView setDelegate:self];
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
    FilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FilterCollectionViewCell class]) forIndexPath:indexPath];
    
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
    FilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FilterCollectionViewCell class]) forIndexPath:indexPath];
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
    [self.dataManager updateFilteredResultsWithDrinkType:self.preferredDrink withCompanyType:self.preferredCompany];
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.bounds.size.width - 5 * FilterCollectionViewEdgeInset ) / 3, FilterCollectionViewCellHeight);
}

@end
