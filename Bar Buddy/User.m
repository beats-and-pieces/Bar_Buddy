//
//  User.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 28/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "User.h"
#import "JSONAdapter.h"

@implementation User

- (instancetype)initWithDisplayedName:(NSString *)displayedName withUserName:(NSString *)userName;
{
    self = [super init];
    if (self) {
        _displayedName = displayedName;
        _userName = userName;
        
    }
    return self;
}

- (instancetype)initWithDisplayedName:(NSString *)displayedName withUserName:(NSString *)userName withLongitude:(NSString *)longitude withLatutude:(NSString *)latutude;
{
    self = [super init];
    if (self) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        float longitudeFloat = [numberFormatter numberFromString: longitude].floatValue;
        float latitudeFloat = [numberFormatter numberFromString: latutude].floatValue;
        _locationLongitude = longitudeFloat;
        _locationLatitude = latitudeFloat;
        _displayedName = displayedName;
        _userName = userName;
        
        
    }
    return self;
}

- (instancetype)initWithJSON:(JSONAdapter *)adapter;
{
    self = [super init];
    if (self) {
        _locationLongitude = adapter.locationLongitude;
        _locationLatitude = adapter.locationLatitude;
        _displayedName = adapter.displayedName;
        _userName = adapter.userName;
    }
    return self;
}

@end
