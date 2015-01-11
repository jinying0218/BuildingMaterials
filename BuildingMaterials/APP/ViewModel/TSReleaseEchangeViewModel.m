//
//  TSReleaseEchangeViewModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/11.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSReleaseEchangeViewModel.h"

@implementation TSReleaseEchangeViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.urlArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
@end
