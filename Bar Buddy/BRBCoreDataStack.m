//
//  BRBCoreDataStack.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 01/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBCoreDataStack.h"

@implementation BRBCoreDataStack

@synthesize persistentContainer = _persistentContainer;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _persistentContainer = [self persistentContainer];
    }
    return self;
}


- (NSPersistentContainer *)persistentContainer
{
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Bar_Buddy"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
            }];
        }
    }
    
    return _persistentContainer;
}


- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
    }
}

@end
