//
//  TSInviteDetailViewModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/5.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSInviteDetailViewModel.h"

@implementation TSInviteDetailViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.comanyModel = [[TSInviteComanyModel alloc] init];
        self.postModel = [[TSInvitePostModel alloc] init];
    }
    return self;
}
@end
