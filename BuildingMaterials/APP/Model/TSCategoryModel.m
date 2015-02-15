//
//  TSCategoryModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/4.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSCategoryModel.h"

@implementation TSCategoryModel
- (void)setValueForDictionary:(NSDictionary *)dict{
    self.classifyDes = dict[@"classifyDes"];
    self.classifyImageUrl = dict[@"classifyImageUrl"];
    self.classifyName = dict[@"classifyName"];
    self.classifyID = [dict[@"id"] intValue];
}
- (void)modelWithDictionary:(NSDictionary *)dict{
    self.classifyDes = dict[@"CLASSIFY_DES"];
    self.classifyImageUrl = dict[@"CLASSIFY_IMAGE_URL"];
    self.classifyName = dict[@"CLASSIFY_NAME"];
    self.classifyID = [dict[@"ID"] intValue];
}

@end
