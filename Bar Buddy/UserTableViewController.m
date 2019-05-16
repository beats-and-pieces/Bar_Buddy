//
//  UsersTableViewController.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "UserTableViewController.h"
#import "UserTableView.h"
#import "UserTableViewCell.h"
#import "FilterCollectionViewCell.h"
#import "DataManagerProtocol.h"
#import "ProjectSettings.h"


@interface UserTableViewController () <UITableViewDataSource, UITableViewDelegate, DataManagerProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonnull, strong) UITableView *tableView;
@property (nonnull, strong) UICollectionView *collectionView;
@property (nullable, strong) DataManager *dataManager;

@property (nonatomic) NSInteger preferredDrink;
@property (nonatomic) NSInteger preferredCompany;
@property (nonatomic, copy) NSArray<NSString *> *drinkFilterValues;
@property (nonatomic, copy) NSArray<NSString *> *topicFilterValues;

@end

@implementation UserTableViewController

- (instancetype)initWithDataManager:(DataManager *)dataManager
{
    self = [super init];
    if (self) {
        _dataManager = dataManager;
        _dataManager.delegate = self;
        _drinkFilterValues = @[@"🍺", @"🍷", @"🥃"];
        _topicFilterValues = @[@"🏎", @"🎼", @"💼"];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    
    [self.dataManager loadData];
}

- (void)createView
{
    CGRect frame = CGRectMake(0, self.navigationController.navigationBar.bounds.size.height, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.bounds.size.height - self.tabBarController.tabBar.bounds.size.height);
    UserTableView *userTableView = [[UserTableView alloc] initWithFrame:frame];
    [self.view addSubview:userTableView];
    //    self.view = userTableView;
    self.tableView = userTableView.tableView;
    self.collectionView = userTableView.collectionView;
    
    [self.collectionView registerClass:[FilterCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([FilterCollectionViewCell class])];
    [self.tableView registerClass:[UserTableViewCell class] forCellReuseIdentifier:NSStringFromClass([UserTableViewCell class])];
    
    self.navigationItem.title = UserTableViewNavigationTitle;
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
    
    cell.usernameLabel.text = self.dataManager.users[indexPath.row].displayedName;
    //    cell.descriptionLabel.text = [NSString stringWithFormat:@"%i", self.dataManager.users[indexPath.row].preferredDrink];
    cell.descriptionLabel.text = self.drinkFilterValues[self.dataManager.users[indexPath.row].preferredDrink - 1];
    if (!cell.userpicImageView.image)
    {
        cell.userpicImageView.image = [UIImage imageNamed:PlaceholderFilename];
        
    }
    
    NSString *userpicURL = self.dataManager.users[indexPath.row].userpicURL;
    [self.dataManager dowloadUserpicFromURL:userpicURL forIndexPath:indexPath];
    
    return cell;
}

- (void)setUserpicForCellAtIndexPath:(NSIndexPath *)indexPath withData:(NSData *)data
{
    UIImage *image = [UIImage imageWithData:data];
    if (image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UserTableViewCell *updateCell = (id)[self.tableView cellForRowAtIndexPath:indexPath];
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
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserTableViewCell class])];
    
    NSString *userName = cell.usernameLabel.text;
    [self sendDrinkRequest:userName];
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

//forrow

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FilterCollectionViewCell class]) forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
            cell.nameLabel.text = self.drinkFilterValues[indexPath.row];
            break;
        case 1:
            cell.nameLabel.text = self.topicFilterValues[indexPath.row];
            break;
        default:
            break;
    }
    
    return cell;
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
//    cell cha
    
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.bounds.size.width - 5 * FilterCollectionViewEdgeInset ) / 3, FilterCollectionViewCellHeight);
}

#pragma mark - ViewControllerFactoryProtocol

/**
 Метод возвращает строку для отображения в Tab Bar контроллере

 @return строка - название закладки данного контроллера для Tab Bar
 */
- (NSString *)getTabBarItemTitle
{
    return UserTableViewTabBarItemTitle;
}




- (void)sendDrinkRequest:(NSString *)userName
{
//    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
//                                                                   message:@"This is an alert."
//                                                            preferredStyle:UIAlertControllerStyleAlert];
//
//    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//                                                          handler:^(UIAlertAction * action) {}];
//
//    [alert addAction:defaultAction];
//    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:userName
                                  message:@"Послать дринк-реквест пользователю?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}
@end
