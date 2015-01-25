//
//  TSShopCarViewModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSShopCarMoneyModel.h"

@interface TSShopCarViewModel : NSObject
//@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *subviewModels;
@property (nonatomic, strong) TSShopCarMoneyModel *shopCarMoney;
@property (nonatomic, assign) float shopCarGoodsMoney;
@property (nonatomic, assign) BOOL allInShopCar;    //用来判断是否有物品从购物车删除

@end
