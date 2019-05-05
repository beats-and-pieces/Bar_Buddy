//
//  NetworkServiceOutputProtocol.h
//  NetworkServiceOutputProtocol
//
//  Created by Anton Kuznetsov on 23.04.19.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

@protocol NetworkServiceOutputProtocol <NSObject>

- (void)loadingIsDoneWithDataRecieved:(NSArray *)dataRecieved;
- (void)userpicIsLoadedWithDataReceived:(NSData *)data forIndexPath:(NSIndexPath *)indexPath;

@end



