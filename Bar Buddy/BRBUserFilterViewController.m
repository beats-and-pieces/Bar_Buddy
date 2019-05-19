//
//  BRBUserFilterController.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 18/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBUserFilterViewController.h"
#import "BRBFilterCollectionViewCell.h"
#import "BRBDataContainer.h"
#import "BRBUserFilterView.h"
#import "ProjectSettings.h"

@interface BRBUserFilterViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//@property (nonatomic, strong) BRBUserFilterView *userFilterView;
@property (nonatomic, strong) BRBDataContainer *dataContainer;

@property (nonatomic) NSInteger preferredDrink;
@property (nonatomic) NSInteger preferredCompany;
@property (nonatomic, copy) NSArray<NSString *> *drinkFilterValues;
@property (nonatomic, copy) NSArray<NSString *> *topicFilterValues;

@property (nonatomic) CGRect frame;

@end

@implementation BRBUserFilterViewController

- (instancetype)initWithDataContainer:(BRBDataContainer *)dataContainer
{
    self = [super init];
    if (self) {
        _dataContainer = dataContainer;
        _drinkFilterValues = @[@"🍺", @"🍷", @"🥃"];
        _topicFilterValues = @[@"🏎", @"🎼", @"💼"];
        [self getUserFilterView];

    }
    return self;
}

- (UIView *)getUserFilterView
{
    //    self.userFilterView = [BRBUserFilterView new];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
       layout.sectionInset = UIEdgeInsetsMake(BRBFilterCollectionViewEdgeInset, BRBFilterCollectionViewEdgeInset, BRBFilterCollectionViewEdgeInset, BRBFilterCollectionViewEdgeInset);
    self.userFilterView = [[BRBUserFilterView alloc] initWithFrame:CGRectMake(0, 0, 10, 10) collectionViewLayout:layout];;
    
    
    
    [self.userFilterView setBackgroundColor:[UIColor colorWithRed: 143.0/255.0 green:174.0/255 blue:224.0/255 alpha: 1.0]];
    
    [self.userFilterView registerClass:[BRBFilterCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([BRBFilterCollectionViewCell class])];
    
    [self.userFilterView setDataSource:self];
    [self.userFilterView setDelegate:self];
    [self.view addSubview:self.userFilterView];
    return self.userFilterView;
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


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.bounds.size.width - 5 * BRBFilterCollectionViewEdgeInset ) / 3, BRBFilterCollectionViewCellHeight);
}

@end
