//
//  TSOrderModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/7.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSOrderModel.h"

@implementation TSOrderModel
- (void)modelWithDict:(NSDictionary *)dict{
    self.CC_ID = [[self objectOrNilForKey:@"CC_ID" fromDictionary:dict] intValue];
    self.companyName = [self objectOrNilForKey:@"COMPANY_NAME" fromDictionary:dict];
    self.C_ID = [[self objectOrNilForKey:@"C_ID" fromDictionary:dict] intValue];
    self.goodsHeadImageURL = [self objectOrNilForKey:@"GOODS_HEAD_IMAGE" fromDictionary:dict];
    self.goodsName = [self objectOrNilForKey:@"GOODS_NAME" fromDictionary:dict];
    self.goodsNumber = [[self objectOrNilForKey:@"GOODS_NUMBER" fromDictionary:dict] intValue];
    self.goodsParameters = [self objectOrNilForKey:@"GOODS_PARAMETERS" fromDictionary:dict];
    self.goodsWeight = [[self objectOrNilForKey:@"GOODS_WEIGHT" fromDictionary:dict] intValue];
    self.G_ID = [[self objectOrNilForKey:@"G_ID" fromDictionary:dict] intValue];
    self.price = [[self objectOrNilForKey:@"PRICE" fromDictionary:dict] intValue];
    self.seckillId = [[self objectOrNilForKey:@"SECKILL_ID" fromDictionary:dict] intValue];

}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
