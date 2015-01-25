//
//  TSShopCarCellSubviewModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSShopCarModel.h"
#import "TSShopCarMoneyModel.h"

@interface TSShopCarCellSubviewModel : NSObject
@property (nonatomic, strong) TSShopCarModel *shopCarModel;
@property (nonatomic, assign) int goodsCount;       //当前物品个数
@property (nonatomic, assign) float goodsTotalMoney;    //当前物品的总价钱
@property (nonatomic, strong) TSShopCarMoneyModel *shopCarMoney;    //购物车内商品总价格 即：结算价格

@end
