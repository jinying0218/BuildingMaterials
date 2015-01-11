//
//  TSExchangeModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/3.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSExchangeModel.h"

@implementation TSExchangeModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
- (void)setValueWithDict:(NSDictionary *)dict{
    
    self.EXCHANGE_TIME = [self objectOrNilForKey:@"EXCHANGE_TIME" fromDictionary:dict];
    self.I_D = [[self objectOrNilForKey:@"ID" fromDictionary:dict] intValue];
    self.N_O = [self objectOrNilForKey:@"NO" fromDictionary:dict];
    self.THINGS_AREA = [self objectOrNilForKey:@"THINGS_AREA" fromDictionary:dict];
    self.THINGS_DES = [self objectOrNilForKey:@"THINGS_DES" fromDictionary:dict];
    self.THINGS_HEAD_IMAGE = [self objectOrNilForKey:@"THINGS_HEAD_IMAGE" fromDictionary:dict];
    self.THINGS_NAME = [self objectOrNilForKey:@"THINGS_NAME" fromDictionary:dict];
    self.THINGS_TEL_PHONE = [self objectOrNilForKey:@"THINGS_TEL_PHONE" fromDictionary:dict];
    self.THINGS_USER_NAME = [self objectOrNilForKey:@"THINGS_USER_NAME" fromDictionary:dict];
    self.THINGS_WANTS = [self objectOrNilForKey:@"THINGS_WANTS" fromDictionary:dict];
    self.THING_NEWS = [self objectOrNilForKey:@"THING_NEWS" fromDictionary:dict];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
