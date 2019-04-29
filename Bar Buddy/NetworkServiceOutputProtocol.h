//
//  NetworkServiceOutputProtocol.h
//  NetworkServiceOutputProtocol
//
//  Created by Anton Kuznetsov on 23.04.19.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

@protocol NetworkServiceOutputProtocol <NSObject>

- (void)loadingIsDoneWithDataRecieved:(NSArray *)dataRecieved;
@optional
- (void)loadingContinuesWithProgress:(double)progress;
- (void)imageIsLoadedForUrl:(NSString *)url withDataReceived:(NSData *)dataReceived;

@end



