//
//  AlertController.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 18/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertController : NSObject

@property (nonatomic, nullable, weak) UIViewController *delegate; /**< Делегат внешних событий */

- (instancetype)initWithViewController:(UIViewController *)viewController;
- (void)showAlertForDrinkRequestTo:(NSString *)userName;
- (void)showAlertForUnableToSendDrinkRequestTo:(NSString *)userName;

@end

NS_ASSUME_NONNULL_END
