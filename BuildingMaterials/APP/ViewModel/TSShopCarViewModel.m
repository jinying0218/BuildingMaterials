//
//  TSShopCarViewModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSShopCarViewModel.h"

@implementation TSShopCarViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _subviewModels = [[NSMutableArray alloc] initWithCapacity:0];
        _shopCarMoney = [[TSShopCarMoneyModel alloc] init];
        _allInShopCar = YES;
        [self blindViewModel];
    }
    return self;
}
- (void)blindViewModel{
    [self.KVOController
     observe:self.shopCarMoney
     keyPath:@keypath(self.shopCarMoney,money)
     options:NSKeyValueObservingOptionNew
     block:^(TSShopCarViewModel *observer, TSShopCarMoneyModel *object, NSDictionary *change) {
         if (![change[NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             [observer setShopCarGoodsMoney:[change[NSKeyValueChangeNewKey] floatValue]];
         }
    }];
}
@end
