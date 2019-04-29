//
//  NetworkService.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 26/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "NetworkService.h"
#import "NetworkServiceInputProtocol.h"

@interface NetworkService () <NetworkServiceInputProtocol>

@end

@implementation NetworkService

#pragma mark - NetworkServiceIntputProtocol

- (void)fetchUserData
{
    NSString *urlString = [NSString stringWithFormat:@"http://private-4df08-barbuddy.apiary-mock.com/users"];
    //    http://private-4df08-barbuddy.apiary-mock.com/questions
    //    NSString *urlString = [NSString stringWithFormat:@"http://private-4df08-barbuddy.apiary-mock.com/questions"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:15];
    
    NSURLSession *session;
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //    return session;
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error)
        {
            NSDictionary *JSONResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSArray *users = [JSONResponse valueForKey:@"users"];
            NSLog(@"%@", users);
            
            if([users isKindOfClass:[NSArray class]]){
                //Is array
                NSLog(@"it's an array");
            }else if([users isKindOfClass:[NSDictionary class]]){
                //is dictionary
                NSLog(@"it's a dict");
            }else{
                //is something else
            }
            for (NSDictionary *user in users)
            {
                NSLog(@"%@", [user valueForKey:@"displayed_name"]);
                NSLog(@"%@", [user valueForKey:@"user_name"]);
            }
            [self.output loadingIsDoneWithDataRecieved:users];
        }
        else
        {
            NSLog(@"Error occured!");
        }
    }];
    [sessionDataTask resume];
}
@end
