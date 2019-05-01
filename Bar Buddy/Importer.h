//
//  Importer.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 01/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NetworkService.h"

NS_ASSUME_NONNULL_BEGIN


@interface Importer : NSObject

- (id)initWithContext:(NSManagedObjectContext *)context networkService:(NetworkService *)networkService;
- (void)import;

@end


NS_ASSUME_NONNULL_END
