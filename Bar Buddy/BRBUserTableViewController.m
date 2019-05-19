//
//  UsersTableViewController.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBUserTableViewController.h"
#import "BRBUserTableView.h"
#import "BRBUserTableViewCell.h"
#import "BRBFilterCollectionViewCell.h"
//#import "BRBDataContainerDelegateProtocol.h"
#import "ProjectSettings.h"
#import "BRBAlertController.h"
#import "BRBUserFilterViewController.h"


@interface BRBUserTableViewController () <UITableViewDataSource, UITableViewDelegate, BRBDataContainerDelegateProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) BRBDataContainer *dataManager;
@property (nonatomic) BRBAlertController *alertController;
@property (nonatomic) BRBUserFilterViewController *userFilterController;

@property (nonatomic) NSInteger preferredDrink;
@property (nonatomic) NSInteger preferredCompany;
@property (nonatomic, copy) NSArray<NSString *> *drinkFilterValues;
@property (nonatomic, copy) NSArray<NSString *> *topicFilterValues;
@property (nonatomic) CGRect frame;


@end

@implementation BRBUserTableViewController

- (instancetype)initWithDataManager:(BRBDataContainer *)dataManager
{
    self = [super init];
    if (self) {
        _dataManager = dataManager;
        _dataManager.delegate = self;
        _drinkFilterValues = @[@"🍺", @"🍷", @"🥃"];
        _topicFilterValues = @[@"🏎", @"🎼", @"💼"];
        _alertController = [[BRBAlertController alloc] initWithViewController:self];
        _alertController.delegate = self;
        
        
        //        _userFilterController =
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
    
    [self.dataManager loadData];
}

- (void)createView
{
    
    
    CGRect frame = CGRectMake(0, self.navigationController.navigationBar.bounds.size.height, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.bounds.size.height - self.tabBarController.tabBar.bounds.size.height);
//    self.userFilterController = [[BRBUserFilterController alloc] initWithDataManager:self.dataManager withFrame:frame];
//    [self.view addSubview:[self.userFilterController getUserFilterView]];
    BRBUserTableView *userTableView = [[BRBUserTableView alloc] initWithFrame:frame];
    [self.view addSubview:userTableView];
    
    
    
    self.tableView = userTableView.tableView;
    self.collectionView = userTableView.collectionView;
    
    [self.collectionView registerClass:[BRBFilterCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([BRBFilterCollectionViewCell class])];
    [self.tableView registerClass:[BRBUserTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BRBUserTableViewCell class])];
    
    self.navigationItem.title = BRBUserTableViewNavigationTitle;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
}


#pragma mark - DataManagerProtocol

- (void)updateTableView
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
    BRBUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BRBUserTableViewCell class])];
    cell.backgroundColor = UIColor.whiteColor;
    cell.usernameLabel.text = self.dataManager.users[indexPath.row].displayedName;
    cell.descriptionLabel.text = self.drinkFilterValues[self.dataManager.users[indexPath.row].preferredDrink - 1];
    if (!cell.userpicImageView.image)
    {
        cell.userpicImageView.image = [UIImage imageNamed:BRBPlaceholderFilename];
    }
    
    cell.contentView.backgroundColor = UIColor.greenColor;
    NSString *userpicURL = self.dataManager.users[indexPath.row].userpicURL;
    if (self.dataManager.users[indexPath.row].isDrinking)
    {
        cell.contentView.backgroundColor = UIColor.redColor;
    }
    [self.dataManager dowloadUserpicFromURL:userpicURL forIndexPath:indexPath];
    
    return cell;
}

- (void)setUserpicForCellAtIndexPath:(NSIndexPath *)indexPath withData:(NSData *)data
{
    UIImage *image = [UIImage imageWithData:data];
    if (image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            BRBUserTableViewCell *updateCell = (id)[self.tableView cellForRowAtIndexPath:indexPath];
            if (updateCell)
                updateCell.userpicImageView.image = image;
        });
    }
    else
    {
        NSLog(@"couldn't get image");
    }
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    User *user = self.dataManager.users[indexPath.row];
    if (user.isDrinking)
    {
        [self.alertController showAlertForUnableToSendDrinkRequestTo:user.displayedName];
    }
    else
    {
        [self sendDrinkRequestTo:user.displayedName];
    }
    
}

- (void)sendDrinkRequestTo:(NSString *)userName
{
    [self.alertController showAlertForDrinkRequestTo:userName];
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
    [self.dataManager updateFilteredResultsWithDrinkType:self.preferredDrink withCompanyType:self.preferredCompany];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.bounds.size.width - 5 * BRBFilterCollectionViewEdgeInset ) / 3, BRBFilterCollectionViewCellHeight);
}


#pragma mark - ViewControllerFactoryProtocol

- (NSString *)getTabBarItemTitle
{
    return BRBUserTableViewTabBarItemTitle;
}

@end
