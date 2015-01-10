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
    self.goodsClassifyId = [dict[@"goodsClassifyId"] intValue];
    self.goodsCompanyId = [dict[@"goodsCompanyId"] intValue];
    if (![dict[@"goodsDes"] isEqual:[NSNull null]]) {
        self.goodsDes = dict[@"goodsDes"] ? dict[@"goodsDes"] : @"";
    }
    self.goodsDesSimple = [self objectOrNilForKey:@"goodsDesSimple" fromDictionary:dict];
    self.goodsHeadImage = [self objectOrNilForKey:@"goodsHeadImage" fromDictionary:dict];
    self.goodsName = [self objectOrNilForKey:@"goodsName" fromDictionary:dict];

    self.goodsNewPrice = [dict[@"goodsNewPrice"] intValue];
    if (![dict[@"goodsOldPrice"] isEqual:[NSNull null]]) {
        self.goodsOldPrice = [dict[@"goodsOldPrice"] intValue];
    }
    
    self.goodsSellNumber = [dict[@"goodsSellNumber"] intValue];
    self.goodsWeight = [dict[@"goodsWeight"] intValue];
    self.goodsID = [dict[@"id"] intValue];
    self.isRecommend = [dict[@"isRecommend"] intValue];
    self.isUsed = [dict[@"isUsed"] intValue];
    self.recommendTime = dict[@"recommendTime"];

}

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
