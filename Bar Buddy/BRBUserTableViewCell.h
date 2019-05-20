//
//  BRBUserTableViewCell.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 25/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRBUserTableViewCell : UITableViewCell

@property (nonatomic, nonnull, strong) UIImageView *userpicImageView; /**< ImageView для отображения автарки пользователя */
@property (nonatomic, nonnull, strong) UILabel *usernameLabel; /**< Лейбл для отображения имени пользователя */
@property (nonatomic, nonnull, strong) UILabel *drinkAndTopicLabel; /**< Общий лейбл для отображения предпочитаемого напитка и темы для разговоров пользователя */
@property (nonatomic, nonnull, strong) UILabel *isDrinkingLabel; /**< Лейбл для отображения статуса доступности пользователя */

@end

NS_ASSUME_NONNULL_END
