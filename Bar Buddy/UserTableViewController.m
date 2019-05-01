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
//#import "User.h"

@interface UserTableViewController () <UITableViewDataSource, UITableViewDelegate, DataManagerProtocol>

@property (nonnull, strong) UITableView *tableView;
@property (nullable, strong) DataManager *dataManager;

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
    [self setupTable];
    
    self.dataManager.delegate = self;
    [self.dataManager loadData];
    
}

- (void)setupTable
{
    self.view.backgroundColor = UIColor.redColor;
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
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
    
    return cell;
}
@end
