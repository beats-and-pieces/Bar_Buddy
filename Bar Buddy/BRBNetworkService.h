//
//  BRBNetworkService.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 26/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol BRBNetworkServiceOutputProtocol <NSObject>

- (void)loadingIsDoneWithDataRecieved:(NSArray *)dataRecieved;
- (void)userpicIsLoadedWithDataReceived:(NSData *)data forIndexPath:(NSIndexPath *)indexPath;

@end


@interface BRBNetworkService : NSObject

@property (nonatomic, nullable, weak) id<BRBNetworkServiceOutputProtocol> output; /**< Делегат внешних событий */

- (void)fetchUserData;
- (void)dowloadUserpicFromURL:(NSString *)urlString forIndexPath:(NSIndexPath *)indexPath;

@end
