//
//  BRBCoreDataStack.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 01/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


NS_ASSUME_NONNULL_BEGIN

@interface BRBCoreDataStack : NSObject

@property (nonatomic, readonly) NSPersistentContainer *persistentContainer;

@end

NS_ASSUME_NONNULL_END
