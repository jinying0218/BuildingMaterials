//
//  TSHavePayedViewModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/7.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSHavePayedViewModel.h"

@implementation TSHavePayedViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
@end
