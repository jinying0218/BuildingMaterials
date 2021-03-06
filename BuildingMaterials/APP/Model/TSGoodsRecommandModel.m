//
//  TSGoodsRecommandModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/3.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSGoodsRecommandModel.h"

@implementation TSGoodsRecommandModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (void)setValueForDictionary:(NSDictionary *)dict{
    
    self.GOODS_CLASSIFY_ID = [dict[@"GOODS_CLASSIFY_ID"] intValue];
    self.GOODS_COMPANY_ID = [dict[@"GOODS_COMPANY_ID"] intValue];
    self.GOODS_DES = dict[@"GOODS_DES"];
    self.GOODS_DES_SIMPLE = [self objectOrNilForKey:@"GOODS_DES_SIMPLE" fromDictionary:dict];
    self.GOODS_HEAD_IMAGE = dict[@"GOODS_HEAD_IMAGE"];
    self.GOODS_NAME = dict[@"GOODS_NAME"];
    self.GOODS_NEW_PRICE = [dict[@"GOODS_NEW_PRICE"] floatValue];
    self.GOODS_OLD_PRICE = [[self objectOrNilForKey:@"GOODS_OLD_PRICE" fromDictionary:dict] floatValue];
    self.GOODS_SELL_NUMBER = [dict[@"GOODS_SELL_NUMBER"] intValue];
    self.GOODS_WEIGHT = [dict[@"GOODS_WEIGHT"] intValue];
    self.I_D = [dict[@"ID"] intValue];
    self.IS_RECOMMEND = [dict[@"IS_RECOMMEND"] intValue];
    self.IS_USED = [dict[@"IS_USED"] intValue];
    self.N_O = [dict[@"NO"] intValue];

}
#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
