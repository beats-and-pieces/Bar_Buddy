//
//  BRBCoreDataStack.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 01/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBCoreDataStack.h"

@interface BRBCoreDataStack ()

@property (nonatomic, nullable) NSError *error;

@end

@implementation BRBCoreDataStack

@synthesize persistentContainer = _persistentContainer;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _persistentContainer = [self persistentContainer];
    }
    if (_error || !_persistentContainer)
    {
        return nil;
    }
    return self;
}


- (NSPersistentContainer *)persistentContainer
{
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Bar_Buddy"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                self.error = error;
            }];
        }
    }
    return _persistentContainer;
}


@end
