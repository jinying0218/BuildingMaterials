//
//  TSOrderConfirmViewModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/31.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSOrderConfirmViewModel.h"

@implementation TSOrderConfirmViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
        _transportsArray = [[NSMutableArray alloc] initWithCapacity:0];
        _subviewModels = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

@end
