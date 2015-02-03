//
//  TSPublishViewModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/3.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSPublishViewModel.h"

@implementation TSPublishViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _imageURLArray = [[NSMutableArray alloc] initWithCapacity:0];
        _imageArray = [[NSMutableArray alloc] initWithCapacity:0];
        _imageContent = [[NSMutableString alloc] initWithCapacity:0];
    }
    return self;
}
@end
