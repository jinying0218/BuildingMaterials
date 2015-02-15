//
//  TSGoodsInfoModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/9.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSGoodsInfoModel.h"

@implementation TSGoodsInfoModel
- (void)setValueForDictionary:(NSDictionary *)dict{
    self.goodsClassifyId = [[self objectOrNilForKey:@"goodsClassifyId" fromDictionary:dict] intValue];
    self.goodsCompanyId = [[self objectOrNilForKey:@"goodsCompanyId" fromDictionary:dict] intValue];
    self.goodsDes = [self objectOrNilForKey:@"goodsDes" fromDictionary:dict];

    self.goodsDesSimple = [self objectOrNilForKey:@"goodsDesSimple" fromDictionary:dict];
    self.goodsHeadImage = [self objectOrNilForKey:@"goodsHeadImage" fromDictionary:dict];
    self.goodsName = [self objectOrNilForKey:@"goodsName" fromDictionary:dict];

    self.goodsNewPrice = [[self objectOrNilForKey:@"goodsNewPrice" fromDictionary:dict] floatValue];
    self.goodsOldPrice = [[self objectOrNilForKey:@"goodsOldPrice" fromDictionary:dict] floatValue];

    self.goodsSellNumber = [[self objectOrNilForKey:@"goodsSellNumber" fromDictionary:dict] intValue];
    self.goodsWeight = [[self objectOrNilForKey:@"goodsWeight" fromDictionary:dict] floatValue];
    self.goodsID = [[self objectOrNilForKey:@"id" fromDictionary:dict] intValue];
    self.isRecommend = [[self objectOrNilForKey:@"isRecommend" fromDictionary:dict] intValue];
    self.isUsed = [[self objectOrNilForKey:@"isUsed" fromDictionary:dict] intValue];
    self.recommendTime = [self objectOrNilForKey:@"recommendTime" fromDictionary:dict];

}

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
