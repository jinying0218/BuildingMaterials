//
//  TSTSSecondsDealViewModel.m
//  BuildingMaterials
//
//  Created by Ariel on 14/11/30.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSSecondsDealViewModel.h"

@implementation TSSecondsDealViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
@end
