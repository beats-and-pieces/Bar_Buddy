//
//  JSONAdapter.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 28/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "JSONAdapter.h"

@implementation JSONAdapter

- (instancetype)initWithJSON:(NSDictionary *)json;
{
    self = [super init];
    if (self) {
        
        NSString *displayedName = json[@"displayed_name"];
        NSString *userName = json[@"user_name"];
        NSString *latitude = json[@"latitude"];
        NSString *longitude = json[@"longitude"];
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        float longitudeFloat = [numberFormatter numberFromString: longitude].floatValue;
        float latitudeFloat = [numberFormatter numberFromString: latitude].floatValue;
        
        _locationLongitude = longitudeFloat;
        _locationLatitude = latitudeFloat;
        _displayedName = displayedName;
        _userName = userName;
        
    }
    return self;
}

@end
