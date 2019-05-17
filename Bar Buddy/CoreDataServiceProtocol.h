
//
//  CoreDataServiceProtocol.h
//  CoreDataServiceProtocol
//
//  Created by Anton Kuznetsov on 23.04.19.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

@protocol CoreDataServiceProtocol <NSObject>

- (NSArray<User *> *) getUserData;
- (void)saveUserData:(NSArray<User *> *)users;

@end



