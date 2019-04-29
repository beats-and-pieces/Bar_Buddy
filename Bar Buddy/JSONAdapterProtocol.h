//
//  JSONAdapterProtocol.h
//  JSONAdapterProtocol
//
//  Created by Anton Kuznetsov on 23.04.19.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

@protocol JSONAdapterProtocol <NSObject>

@property (nonnull, strong) NSString *displayedName;
@property (nonnull, strong) NSString *userName;
@property int preferredDrink;
@property int preferredCompany;
@property double locationLatitude;
@property double locationLongitude;

@end
