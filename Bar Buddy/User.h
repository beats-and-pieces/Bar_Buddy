//
//  User.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 28/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonnull, strong) NSString *displayedName;
@property (nonnull, strong) NSString *userName;
@property int preferredDrink;
@property int preferredCompany;
@property double locationLatitude;
@property double locationLongitude;

- (instancetype)initWithJSON:(JSONAdapter *)adapter;

@end

NS_ASSUME_NONNULL_END
