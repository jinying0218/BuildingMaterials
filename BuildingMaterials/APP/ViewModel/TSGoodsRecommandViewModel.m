//
//  TSGoodsRecommandViewModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/5.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSGoodsRecommandViewModel.h"

@implementation TSGoodsRecommandViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}


@end
