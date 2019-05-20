//
//  BRBNetworkService.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 26/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBNetworkService.h"
#import "ProjectSettings.h"

@interface BRBNetworkService ()

@end


@implementation BRBNetworkService

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSUInteger cacheSizeMemory = 500*1024*1024; // 500 MB
        NSUInteger cacheSizeDisk = 500*1024*1024; // 500 MB
        NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"];
        [NSURLCache setSharedURLCache:sharedCache];
    }
    return self;
}


#pragma mark - NetworkServiceIntputProtocol

- (void)dowloadUserpicFromURL:(NSString *)urlString forIndexPath:(NSIndexPath *)indexPath
{
    NSURLRequest *request = [self createRequestForURL:urlString];
    NSCachedURLResponse *cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
    
    if (cachedResponse.data)
    {
        [self.output userpicIsLoadedWithDataReceived:cachedResponse.data forIndexPath:indexPath];
    }
    else
    {
        NSURLSessionTask *task = [[self createSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                  {
                                      if (data)
                                      {
                                          [self.output userpicIsLoadedWithDataReceived:data forIndexPath:indexPath];
                                      }
                                      else
                                      {
                                          NSLog(@"couldn't get data");
                                      }
                                  }];
        [task resume];
    }
}


- (void)fetchUserData
{
    NSURLSession *session = [self createSession];
    NSURLRequest *request = [self createRequestForURL:BRBBarBuddyAPIURL];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error)
        {
            NSDictionary *JSONResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSArray *users = JSONResponse[@"users"];
            NSLog(@"users %@", users);
            [self.output loadingIsDoneWithDataRecieved:users];
        }
        else
        {
            NSLog(@"Error occured!");
        }
    }];
    [sessionDataTask resume];
}


- (NSURLSession *)createSession
{
    return [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
}

- (NSMutableURLRequest *)createRequestForURL:(NSString *)urlString
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:15];
    return request;
}

@end
