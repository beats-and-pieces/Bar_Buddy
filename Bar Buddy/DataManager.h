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
//#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject 

//@property (nonatomic, copy) NSArray<User *> *users;
@property (nonatomic, copy) NSArray<UserCD *> *users;
@property (nonatomic, weak) id<DataManagerProtocol> delegate; /**< Делегат внешних событий */

+ (id)shared;

- (void)getDataFromServer;
- (void)loadData;

@end

NS_ASSUME_NONNULL_END
