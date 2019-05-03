//
//  JSONAdapter.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 28/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONAdapterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSONAdapter : NSObject <JSONAdapterProtocol>

- (instancetype)initWithJSON:(NSDictionary *)json;

@property (nonnull, strong) NSString *displayedName;
@property (nonnull, strong) NSString *userName;
@property (nonatomic) NSInteger preferredDrink;
@property (nonatomic) NSInteger preferredCompany;
@property double locationLatitude;
@property double locationLongitude;

@end

NS_ASSUME_NONNULL_END
