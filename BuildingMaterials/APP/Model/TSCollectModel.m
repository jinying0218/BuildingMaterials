//
//  TSCollectModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSCollectModel.h"

@implementation TSCollectModel
- (void)setValueWithDict:(NSDictionary *)dict{
    self.collectiong_id = [[self objectOrNilForKey:@"COLLECTION_ID" fromDictionary:dict] intValue];
    self.c_id = [[self objectOrNilForKey:@"C_ID" fromDictionary:dict] intValue];
    self.goods_classify_id = [[self objectOrNilForKey:@"GOODS_CLASSIFY_ID" fromDictionary:dict] intValue];
    self.goods_company_id = [[self objectOrNilForKey:@"GOODS_COMPANY_ID" fromDictionary:dict] intValue];
    self.goods_des = [self objectOrNilForKey:@"GOODS_DES" fromDictionary:dict];
    self.goods_des_simple = [self objectOrNilForKey:@"GOODS_DES_SIMPLE" fromDictionary:dict];
    self.goods_Head_ImageUrl = [self objectOrNilForKey:@"GOODS_HEAD_IMAGE" fromDictionary:dict];
    self.goodsName = [self objectOrNilForKey:@"GOODS_NAME" fromDictionary:dict];

    self.goods_new_price = [[self objectOrNilForKey:@"GOODS_NEW_PRICE" fromDictionary:dict] intValue];
    self.goods_old_price = [[self objectOrNilForKey:@"GOODS_OLD_PRICE" fromDictionary:dict] intValue];
    self.goods_sell_number = [[self objectOrNilForKey:@"GOODS_SELL_NUMBER" fromDictionary:dict] intValue];
    self.goods_weight = [[self objectOrNilForKey:@"GOODS_WEIGHT" fromDictionary:dict] intValue];
    self.Collect_id = [[self objectOrNilForKey:@"ID" fromDictionary:dict] intValue];
    self.is_recommend = [[self objectOrNilForKey:@"IS_RECOMMEND" fromDictionary:dict] intValue];
    self.is_used = [[self objectOrNilForKey:@"IS_USED" fromDictionary:dict] intValue];
    self.recomment_time = [self objectOrNilForKey:@"RECOMMEND_TIME" fromDictionary:dict];

}
#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
