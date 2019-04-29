//
//  CoreDataService.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 29/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserCD+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataService : NSObject

- (NSArray<UserCD *> *) getUserData;


@end

NS_ASSUME_NONNULL_END
