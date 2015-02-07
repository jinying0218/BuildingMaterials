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
@property (nonatomic, assign) int goodsID;      //利用id 获取所有详情信息
@property (nonatomic, strong) TSShopModel *shopModel;
@property (nonatomic, strong) TSGoodsInfoModel *goodsInfoModel;
@property (nonatomic, strong) TSGoodsParamsModel *goodsParamsModel;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) BOOL isSecondsDeal;
@property (nonatomic, assign) BOOL loadGoodsInfo;
@property (nonatomic, assign) BOOL loadGoodsParams;
@property (nonatomic, assign) int paramsCount;   // 选中参数个数

@property (nonatomic, strong) NSMutableArray *paramsValue;  //参数字典
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
