//
//  TSOrderSubviewModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/7.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSOrderSubviewModel.h"

@implementation TSOrderSubviewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _goodsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
@end
