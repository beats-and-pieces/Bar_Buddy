//
//  DataManagerProtocol.h
//  DataManagerProtocol
//
//  Created by Anton Kuznetsov on 23.04.19.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

@protocol DataManagerProtocol <NSObject>

- (void)updateData;
- (void)setUserpicForCellAtIndexPath:(NSIndexPath *)indexPath withData:(NSData *)data;

@end



