//
//  TSInviteViewModel.m
//  BuildingMaterials
//
//  Created by Ariel on 14/12/31.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSInviteViewModel.h"

@implementation TSInviteViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.categoryDataArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

@end
