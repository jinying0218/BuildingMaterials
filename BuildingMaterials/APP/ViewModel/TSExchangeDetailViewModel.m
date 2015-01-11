//
//  TSExchangeDetailViewModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/11.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSExchangeDetailViewModel.h"

@implementation TSExchangeDetailViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.exchangeGoodsModel = [[TSExchangeListModel alloc] init];
        self.imageArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
@end
