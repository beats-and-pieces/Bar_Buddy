//
//  BRBDataContainer.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BRBNetworkServiceOutputProtocol.h"
//#import "BRBDataContainerDelegateProtocol.h"
#import "BRBCoreDataService.h"
#import "BRBNetworkService.h"

@protocol BRBDataContainerDelegateProtocol <NSObject>

- (void)updateTableView;
- (void)setUserpicForCellAtIndexPath:(NSIndexPath *)indexPath withData:(NSData *)data;

@end


@interface BRBDataContainer : NSObject 

@property (nonatomic, copy) NSArray<User *> *users;
@property (nonatomic, copy) NSArray<NSString *> *drinkValues;
@property (nonatomic, copy) NSArray<NSString *> *topicValues;
@property (nonatomic, nullable, weak) id<BRBDataContainerDelegateProtocol> delegate; /**< Делегат, который получает измененные данные */

- (instancetype)initWithCoreDataService:(BRBCoreDataService *)coreDataService withNetworkService:(BRBNetworkService *)networkService;
- (void)loadData;
- (void)updateFilteredResultsWithDrinkType:(NSInteger)drinkType withTopicType:(NSInteger)topicType;
- (void)dowloadUserpicFromURL:(NSString *)urlString forIndexPath:(NSIndexPath *)indexPath;

@end
