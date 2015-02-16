//
//  TSGoodsImageModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/13.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSGoodsImageModel.h"

@implementation TSGoodsImageModel
- (void)modelWithDict:(NSDictionary *)dict{
    self.goodsId = [[self objectOrNilForKey:@"goodsId" fromDictionary:dict] intValue];
    self.goodsImageId = [[self objectOrNilForKey:@"id" fromDictionary:dict] intValue];
    self.isHead = [[self objectOrNilForKey:@"isHead" fromDictionary:dict] intValue];
    
    self.imageDes = [self objectOrNilForKey:@"imageDes" fromDictionary:dict];
    self.imageUrl = [self objectOrNilForKey:@"imageUrl" fromDictionary:dict];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
