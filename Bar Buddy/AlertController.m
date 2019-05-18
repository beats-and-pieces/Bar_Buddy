//
//  AlertController.m
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 18/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import "AlertController.h"

typedef NS_ENUM(NSInteger, BRBAlertType) {
    BRBAlertTypeSuccess,
    BRBAlertTypeFailure
};

@interface AlertController ()

@property (nonatomic, nonnull) NSString *alertTitle;
@property (nonatomic, nonnull) NSString *alertMessage;
@property (nonatomic, nonnull) NSString *alertAcceptanceActionTitle;

@end

@implementation AlertController


- (instancetype)initWithViewController:(UIViewController *)viewController
{
    self = [super init];
    if (self) {
        _delegate = viewController;
    }
    return self;
}

- (void)showAlertForUnableToSendDrinkRequestTo:(NSString *)userName
{
    self.alertTitle = @"Пользователь занят";
    self.alertMessage = [NSString stringWithFormat:@"Вы не можете послать дринк-реквест пользователю %@", userName];
    self.alertAcceptanceActionTitle = @"Печаль...";
    [self showAlertOfType:BRBAlertTypeFailure];
}

- (void)showAlertForDrinkRequestTo:(NSString *)userName
{
    self.alertTitle = userName;
    self.alertMessage = @"Послать дринк-реквест пользователю?";
    self.alertAcceptanceActionTitle = @"ОК";
    [self showAlertOfType:BRBAlertTypeSuccess];
}

- (void)showAlertOfType:(BRBAlertType)alertType
{
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:self.alertTitle message:self.alertMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction
                         actionWithTitle:self.alertAcceptanceActionTitle
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action) {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    [alert addAction:ok];
    
    switch (alertType) {
        case BRBAlertTypeSuccess:
        {
            UIAlertAction* cancel = [UIAlertAction
                                     actionWithTitle:@"Отменить"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action) {
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                     }];
            
            [alert addAction:cancel];
            break;
        }
        default:
            break;
    }
    [self.delegate presentViewController:alert animated:YES completion:nil];
}

@end
