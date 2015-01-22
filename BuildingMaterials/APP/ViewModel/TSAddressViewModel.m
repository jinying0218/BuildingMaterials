//
//  TSAddressViewModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/21.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSAddressViewModel.h"

@implementation TSAddressViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _addressArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
@end
