//
//  BRBUserFilterDelegateAndDataSource.h
//  Bar Buddy
//
//  Created by Anton Kuznetsov on 19/05/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BRBDataContainer;

NS_ASSUME_NONNULL_BEGIN

@interface BRBUserFilterDelegateAndDataSource : NSObject

/**
 Инициализатор с зависомостью от контейнера данных

 @param dataContainer контейнер данных
 @return экземпляр своего класса
 */
- (instancetype)initWithDataContainer:(BRBDataContainer *)dataContainer;


/**
 Устанавливает ширину экрана устройства для расчета размеров ячейки фильтра типа UICollectionViewCell по протоколу UICollectionViewDelegateFlowLayout

 @param width ширина экрана
 */
- (void)setWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
