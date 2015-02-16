//
//  TSSecKillModel.m
//  BuildingMaterials
//
//  Created by Ariel on 14/12/31.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSSecKillModel.h"

@implementation TSSecKillModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (void)setValueForDictionary:(NSDictionary *)dict{
    self.GOODS_DES = [self objectOrNilForKey:@"GOODS_DES" fromDictionary:dict];
    self.GOODS_HEAD_IMAGE = [self objectOrNilForKey:@"GOODS_HEAD_IMAGE" fromDictionary:dict];
    self.GOODS_NAME = [self objectOrNilForKey:@"GOODS_NAME" fromDictionary:dict];
    self.GOODS_NEW_PRICE = [[self objectOrNilForKey:@"GOODS_NEW_PRICE" fromDictionary:dict] floatValue];
    self.goodsId = [[self objectOrNilForKey:@"ID" fromDictionary:dict] intValue];
    self.SECKILL_PRICE = [[self objectOrNilForKey:@"SECKILL_PRICE" fromDictionary:dict] floatValue];
    self.SECKILL_NUMBER = [[self objectOrNilForKey:@"SECKILL_NUMBER" fromDictionary:dict] intValue];
    self.SECKILL_NUMBER_NOW = [[self objectOrNilForKey:@"SECKILL_NUMBER_NOW" fromDictionary:dict] intValue];
    self.S_ID = [[self objectOrNilForKey:@"S_ID" fromDictionary:dict] intValue];
    
    
//    self.END_TIME = [self objectOrNilForKey:@"END_TIME" fromDictionary:dict];
//    self.SecondsDeal_EventID = [[self objectOrNilForKey:@"SecondsDeal_EventID" fromDictionary:dict] intValue];
//    self.STATUS = [[self objectOrNilForKey:@"STATUS" fromDictionary:dict] intValue];
}

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}
@end
