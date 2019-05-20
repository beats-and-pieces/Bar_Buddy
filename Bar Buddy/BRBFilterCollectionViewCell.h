//
//  BRBFilterCollectionViewCell.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 15/04/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRBFilterCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *label; /**< Лейбл для отображения значения фильтра кнопки-ячейки внешних событий */
@property (nonatomic) BOOL isPressed; /**< Признак нажатости/отжатости кнопки */

@end

NS_ASSUME_NONNULL_END
