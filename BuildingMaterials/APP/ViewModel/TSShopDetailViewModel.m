//
//  TSShopDetailViewModel.m
//  BuildingMaterials
//
//  Created by Ariel on 14/12/17.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSShopDetailViewModel.h"

@implementation TSShopDetailViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.shopModel = [[TSShopModel alloc] init];
        self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
@end
