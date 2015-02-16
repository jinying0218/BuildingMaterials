//
//  TSGoodsDetailViewModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/9.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSGoodsDetailViewModel.h"

@implementation TSGoodsDetailViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.goodsInfoModel = [[TSGoodsInfoModel alloc] init];
        self.goodsParamsModel = [[TSGoodsParamsModel alloc] init];
        self.shopModel = [[TSShopModel alloc] init];
        self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.count = 1;
        _paramsValue = [[NSMutableArray alloc] initWithCapacity:0];
        _imageArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
@end
