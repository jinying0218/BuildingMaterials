//
//  TSOrderSubviewModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/2/7.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSTransportModel.h"

@interface TSOrderSubviewModel : NSObject
@property (nonatomic, assign) int companyTotalPrice;      //该分组下的所有商品价格
@property (nonatomic, assign) int transportPrice;
@property (nonatomic, assign) float goodsWeight;
@property (nonatomic, strong) TSTransportModel *transportModel;     //该分组下的运送方式
@property (nonatomic, strong) NSMutableArray *goodsArray;       //改分组下所有的商品

@end
