//
//  UsersTableViewController.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "UserTableViewController.h"
#import "UserTableViewCell.h"
#import "DataManager.h"
#import "DataManagerProtocol.h"
//#import "User.h"

@interface UserTableViewController () <UITableViewDataSource, UITableViewDelegate, DataManagerProtocol>

@property (nonnull, strong) UITableView *tableView;
//@property (nonnull, copy) NSArray<User *> *users;
//@property (strong) BOOL dataIsFromServer;
@property (nonatomic, assign) BOOL dataIsFromServer;

@end

@implementation UserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    DataManager *dataManager = [DataManager shared];
    dataManager.delegate = self;
    [dataManager loadData];
    
    //    dataManager
    // Do any additional setup after loading the view.
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
    self.dataIsFromServer = YES;
    [self.tableView reloadData];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DataManager *dataManager = [DataManager shared];
    if (dataManager.users == nil)
    {
        return 0;
    }
    else
    {
        DataManager *dataManager = [DataManager shared];
        return dataManager.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *title = [NSString new];
    NSString *filePath= [NSString stringWithFormat:@"%ld", (long)indexPath.row + 1];
    if (self.dataIsFromServer == YES)
    {
        DataManager *dataManager = [DataManager shared];
        //        NSLog(@"%@", [dataManager.users[indexPath.row] valueForKey:@"displayed_name"]);
        title = dataManager.users[indexPath.row].displayedName;
        
    }

    
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UserTableViewCell class])];
    
    [cell.coverImageView setImage:[UIImage imageNamed:filePath]];
    cell.titleLabel.text = title;
    //    cell.descriptionLabel.text = description;
    cell.descriptionLabel.font = [UIFont systemFontOfSize:14];
    return cell;
    
}
@end
