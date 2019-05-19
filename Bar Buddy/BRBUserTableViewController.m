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
#import "ProjectSettings.h"
#import "BRBAlertController.h"
#import "BRBUserFilterDelegateAndDataSource.h"


@interface BRBUserTableViewController () <UITableViewDataSource, UITableViewDelegate, BRBDataContainerDelegateProtocol>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) BRBDataContainer *dataContainer;
@property (nonatomic) BRBAlertController *alertController;
@property (nonatomic) BRBUserFilterDelegateAndDataSource *userFilterDelegateAndDataSource;



@end

@implementation BRBUserTableViewController

- (instancetype)initWithDataContainer:(BRBDataContainer *)dataContainer
{
    self = [super init];
    if (self) {
        _dataContainer = dataContainer;
        _dataContainer.delegate = self;
        
        _alertController = [[BRBAlertController alloc] initWithViewController:self];
        _alertController.delegate = self;
        
        self.userFilterDelegateAndDataSource = [[BRBUserFilterDelegateAndDataSource alloc] initWithDataContainer:dataContainer];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
    [self.dataContainer loadData];
}

- (void)createView
{
    CGRect frame = CGRectMake(0, self.navigationController.navigationBar.bounds.size.height, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.bounds.size.height - self.tabBarController.tabBar.bounds.size.height);
    
    BRBUserTableView *userTableView = [[BRBUserTableView alloc] initWithFrame:frame];
    [self.view addSubview:userTableView];

    self.tableView = userTableView.tableView;
    self.collectionView = userTableView.collectionView;
    
    [self.collectionView registerClass:[BRBFilterCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([BRBFilterCollectionViewCell class])];
    [self.tableView registerClass:[BRBUserTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BRBUserTableViewCell class])];
    
    self.navigationItem.title = BRBUserTableViewNavigationTitle;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [self.userFilterDelegateAndDataSource setWidth: self.view.bounds.size.width];
    BRBUserFilterDelegateAndDataSource <UICollectionViewDataSource> *filterDataSource = (BRBUserFilterDelegateAndDataSource <UICollectionViewDataSource> *) self.userFilterDelegateAndDataSource;
    BRBUserFilterDelegateAndDataSource <UICollectionViewDelegate> *filterDelegate = (BRBUserFilterDelegateAndDataSource <UICollectionViewDelegate> *) self.userFilterDelegateAndDataSource;
    
    self.collectionView.dataSource= filterDataSource;
    self.collectionView.delegate = filterDelegate;
}


#pragma mark - BRBDataContainerDelegateProtocol

- (void)updateTableView
{
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataContainer.users ? self.dataContainer.users.count : 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BRBUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BRBUserTableViewCell class])];
    cell.backgroundColor = UIColor.whiteColor;
    cell.usernameLabel.text = self.dataContainer.users[indexPath.row].displayedName;
    cell.descriptionLabel.text = self.dataContainer.drinkValues[self.dataContainer.users[indexPath.row].preferredDrink - 1];
    if (!cell.userpicImageView.image)
    {
        cell.userpicImageView.image = [UIImage imageNamed:BRBPlaceholderFilename];
    }
    
    cell.contentView.backgroundColor = UIColor.greenColor;
    NSString *userpicURL = self.dataContainer.users[indexPath.row].userpicURL;
    if (self.dataContainer.users[indexPath.row].isDrinking)
    {
        cell.contentView.backgroundColor = UIColor.redColor;
    }
    [self.dataContainer dowloadUserpicFromURL:userpicURL forIndexPath:indexPath];
    
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
    User *user = self.dataContainer.users[indexPath.row];
    if (user.isDrinking)
    {
        [self.alertController showAlertForUnableToSendDrinkRequestTo:user.displayedName];
    }
    else
    {
        [self sendDrinkRequestTo:user.displayedName];
    }
}


#pragma mark - ViewControllerFactoryProtocol

- (NSString *)getTabBarItemTitle
{
    return BRBUserTableViewTabBarItemTitle;
}


- (void)sendDrinkRequestTo:(NSString *)userName
{
    [self.alertController showAlertForDrinkRequestTo:userName];
}

@end
