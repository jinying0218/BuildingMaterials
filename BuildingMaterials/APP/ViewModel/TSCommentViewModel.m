//
//  TSCommentViewModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/16.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSCommentViewModel.h"

@implementation TSCommentViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.allComments = [[NSMutableArray alloc] initWithCapacity:0];
        self.page = 1;
    }
    return self;
}
@end
