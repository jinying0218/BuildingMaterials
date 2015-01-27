//
//  TSShopCarModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSShopCarModel.h"

@implementation TSShopCarModel
- (void)setValueWithDict:(NSDictionary *)dict{
    self.CC_ID = [[self objectOrNilForKey:@"CC_ID" fromDictionary:dict] intValue];
    self.C_ID = [[self objectOrNilForKey:@"C_ID" fromDictionary:dict] intValue];
    self.companyName = [self objectOrNilForKey:@"COMPANY_NAME" fromDictionary:dict];
    self.goodsName = [self objectOrNilForKey:@"GOODS_NAME" fromDictionary:dict];
    self.goods_head_imageURL = [self objectOrNilForKey:@"GOODS_HEAD_IMAGE" fromDictionary:dict];
    self.goods_number = [[self objectOrNilForKey:@"GOODS_NUMBER" fromDictionary:dict] intValue];
    self.goods_price = [[self objectOrNilForKey:@"PRICE" fromDictionary:dict] intValue];
    self.goods_id = [[self objectOrNilForKey:@"G_ID" fromDictionary:dict] intValue];
    self.parameters = [self objectOrNilForKey:@"parameters" fromDictionary:dict];

}
#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
