//
//  TSInviteCategoryModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/4.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSInviteCategoryModel.h"

@implementation TSInviteCategoryModel
- (void)setValueForDictionary:(NSDictionary *)dict{
    self.postClassifyName = dict[@"postClassifyName"];
    self.categoryID = [dict[@"id"] intValue];
}
@end
