//
//  UsersTableViewController.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "UserTableViewController.h"
#import "UserTableViewCell.h"
#import "DataManagerProtocol.h"
#import "FilterCollectionViewCell.h"
#import "UserTableView.h"
//#import "User.h"

@interface UserTableViewController () <UITableViewDataSource, UITableViewDelegate, DataManagerProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonnull, strong) UITableView *tableView;
@property (nonnull, strong) UICollectionView *collectionView;
@property (nullable, strong) DataManager *dataManager;

@property (nonatomic) NSInteger preferredDrink;
@property (nonatomic) NSInteger preferredCompany;

@end

@implementation UserTableViewController

- (instancetype)initWithDataManager:(DataManager *)dataManager
{
    self = [super init];
    if (self) {
        _dataManager = dataManager;
    }
    return self;
}



#pragma mark - ViewControllerFactoryProtocol

- (NSString *)getTabBarItemTitle
{
    return @"Список пользователей";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    
    self.dataManager.delegate = self;
    [self.dataManager loadData];
}

- (void)createView
{
    CGRect frame = CGRectMake(0, self.navigationController.navigationBar.bounds.size.height, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    UserTableView *userTableView = [[UserTableView alloc] initWithFrame:frame];
    [self.view addSubview:userTableView];
    //    self.view = userTableView;
    self.tableView = userTableView.tableView;
    self.collectionView = userTableView.collectionView;
    
    [self.collectionView registerClass:[FilterCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([FilterCollectionViewCell class])];
    [self.tableView registerClass:[UserTableViewCell class] forCellReuseIdentifier:NSStringFromClass([UserTableViewCell class])];
    
    self.navigationItem.title = @"Пользователи";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
}

#pragma mark - DataManagerProtocol

- (void)updateData
{
    [self.tableView reloadData];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataManager.users ? self.dataManager.users.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserTableViewCell class])];
    NSString *title = self.dataManager.users[indexPath.row].displayedName;
    cell.titleLabel.text = title;
    cell.descriptionLabel.text = [NSString stringWithFormat:@"%i", self.dataManager.users[indexPath.row].preferredDrink];
    
    return cell;
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
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.bounds.size.width - 5 * 15 ) / 3, 32);
}


//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:NSStringFromClass([UICollectionReusableView class]) withReuseIdentifier:@"HeaderViewIdentifier" forIndexPath:indexPath];
//
//    headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 100);
//    return headerView;
//}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell #%ld at section@%ld", (long)indexPath.row, (long)indexPath.section);
    
    //    NSInteger *drinkType = [NSInteger new];
    
    switch (indexPath.section) {
        case 0:
            self.preferredDrink = indexPath.row;
            break;
        case 1:
            self.preferredCompany = indexPath.row;
            break;
        default:
            break;
    }
    [self.dataManager updateFilteredResultsWithDrinkType:self.preferredDrink withCompanyType:self.preferredCompany];
}
@end
