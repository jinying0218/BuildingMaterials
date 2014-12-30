//
//  TSFristViewModel.m
//  BuildingMaterials
//
//  Created by Ariel on 14/12/31.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSFristViewModel.h"

@implementation TSFristViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.secKillDataArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.shopRecommendDataArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.goodsRecommendDataArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.goodsExchangeDataArray = [[NSMutableArray alloc] initWithCapacity:0];

    }
    return self;
}
@end
