//
//  TSShopGoodsViewModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/9.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSShopGoodsViewModel.h"

@implementation TSShopGoodsViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _page = 1;
        _goodsOrderType = @"1";
        _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
        _popDataArray = [[NSMutableArray alloc] initWithCapacity:0];
        _categoryDataArray = [[NSMutableArray alloc] initWithCapacity:0];
        _sortDataArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

@end
