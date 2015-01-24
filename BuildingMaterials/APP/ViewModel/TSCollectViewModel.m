//
//  TSCollectViewModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSCollectViewModel.h"

@implementation TSCollectViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _goodsDataArray = [[NSMutableArray alloc] initWithCapacity:0];
        _shopDataArray = [[NSMutableArray alloc] initWithCapacity:0];

        _isGoodsCollect = YES;
    }
    return self;
}

@end
