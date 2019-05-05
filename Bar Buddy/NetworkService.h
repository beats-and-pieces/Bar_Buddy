//
//  NetworkService.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 26/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkServiceOutputProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkService : NSObject

@property (nonatomic, weak) id<NetworkServiceOutputProtocol> output; /**< Делегат внешних событий */

- (void)fetchUserData;
- (void)dowloadUserpicFromURL:(NSString *)urlString forIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
