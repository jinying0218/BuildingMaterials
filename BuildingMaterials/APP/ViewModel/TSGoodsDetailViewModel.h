//
//  TSGoodsDetailViewModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/9.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSGoodsInfoModel.h"
#import "TSShopModel.h"
#import "TSGoodsParamsModel.h"

@interface TSGoodsDetailViewModel : NSObject
@property (nonatomic, assign) int goodsID;
@property (nonatomic, strong) TSShopModel *shopModel;
@property (nonatomic, strong) TSGoodsInfoModel *goodsInfoModel;
@property (nonatomic, strong) TSGoodsParamsModel *goodsParamsModel;
@property (nonatomic, assign) int count;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end
