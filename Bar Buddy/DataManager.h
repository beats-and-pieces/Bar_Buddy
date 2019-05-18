//
//  DataManager.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkServiceOutputProtocol.h"
#import "DataManagerProtocol.h"
#import "CoreDataService.h"
#import "NetworkService.h"

@interface DataManager : NSObject 

@property (nonatomic, copy) NSArray<User *> *users;
@property (nonatomic, nullable, weak) id<DataManagerProtocol> delegate; /**< Делегат внешних событий */

- (instancetype)initWithCoreDataService:(CoreDataService *)coreDataService withNetworkService:(NetworkService *)networkService;
- (void)loadData;
- (void)updateFilteredResultsWithDrinkType:(NSInteger)drinkType withCompanyType:(NSInteger)companyType;
- (void)dowloadUserpicFromURL:(NSString *)urlString forIndexPath:(NSIndexPath *)indexPath;

@end
