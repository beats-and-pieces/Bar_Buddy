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

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject 

@property (nonatomic, copy) NSArray<UserCD *> *users;
@property (nonatomic, weak, nullable) id<DataManagerProtocol> delegate; /**< Делегат внешних событий */


- (instancetype)initWithCoreDataService:(CoreDataService *)coreDataService withNetworkService:(NetworkService *)networkService;
- (void)getDataFromServer;
- (void)loadData;


@end

NS_ASSUME_NONNULL_END
