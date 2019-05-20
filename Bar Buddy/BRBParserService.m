//
//  BRBParserService.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 20/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "BRBParserService.h"

@interface BRBParserService ()


@end

@implementation BRBParserService

- (instancetype)initWithJSON:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        NSString *displayedName = json[@"displayed_name"];
        NSString *userName = json[@"user_name"];
        NSString *userpicURL = json[@"userpic_url"];
        NSInteger preferredDrink = [json[@"preferred_drink"] intValue];
        NSInteger preferredCompany = [json[@"preferred_company"] integerValue];
        NSInteger preferredTopic = [json[@"preferred_topic"] integerValue];
        NSNumber *latitude = [NSNumber numberWithFloat: [json[@"latitude"] floatValue]];
        NSNumber *longitude = [NSNumber numberWithFloat: [json[@"longitude"] floatValue]];
        BOOL isDrinking = NO;
        if ([json[@"isDrinking"] isEqualToString:@"TRUE"])
        {
            isDrinking = YES;
        }
        
        self.displayedName = displayedName;
        self.userName = userName;
        self.userpicURL = userpicURL;
        self.preferredDrink = preferredDrink;
        self.preferredCompany = preferredCompany;
        self.preferredTopic = preferredTopic;
        self.locationLatitude = latitude.doubleValue;
        self.locationLongitude = longitude.doubleValue;
        self.isDrinking = isDrinking;
    }
    return self;
}


@end
