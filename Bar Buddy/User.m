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


- (instancetype)initWithJSON:(JSONAdapter *)adapter;
{
    self = [super init];
    if (self) {
        _locationLongitude = adapter.locationLongitude;
        _locationLatitude = adapter.locationLatitude;
        _displayedName = adapter.displayedName;
        _userName = adapter.userName;
        _preferredDrink = adapter.preferredDrink;
        _preferredCompany = adapter.preferredCompany;
        
    }
    return self;
}

@end
