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

- (NSString *)getTabBarItemTitle
{
    return @"Список пользователей";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupCollectionView];
    
    [self setupTable];
    self.dataManager.delegate = self;
    
    [self.dataManager loadData];
    
}

- (void)setupCollectionView
{
    [self setupUICollectionView];
}

- (void)setupTable
{
    //    self.view.backgroundColor = UIColor.redColor;
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 32 * 2 + 15 * 2 + self.navigationController.navigationBar.bounds.size.height, self.view.frame.size.width, self.view.frame.size.height - 32 * 2 + 15 * 2 + self.navigationController.navigationBar.bounds.size.height);
    [self.tableView registerClass:[UserTableViewCell class] forCellReuseIdentifier:NSStringFromClass([UserTableViewCell class])];
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"Пользователи";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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

- (void)setupUICollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    //    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 30);
    //    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderViewIdentifier"];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.bounds.size.height, self.view.bounds.size.width, 32 * 2 + 15 * 2 + self.navigationController.navigationBar.bounds.size.height) collectionViewLayout:layout];
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    [self.collectionView registerClass:[FilterCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([FilterCollectionViewCell class])];
    [self.collectionView setBackgroundColor:[UIColor colorWithRed: 143.0/255.0 green:174.0/255 blue:224.0/255 alpha: 1.0]];
    
    [self.view addSubview:self.collectionView];
    
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

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
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
    //    [self.dataManager getFilteredUsersWithDrinkType:<#(NSInteger)#> withCompanyType:<#(NSInteger)#>:indexPath.row withCompanyType:0];
}
@end
