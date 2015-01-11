//
//  TSExchangeListModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/5.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSExchangeListModel.h"

@implementation TSExchangeListModel
- (void)setValueForDictionary:(NSDictionary *)dict{
    self.EXCHANGE_TIME = dict[@"EXCHANGE_TIME"];
    self.I_D = [dict[@"ID"] intValue];
    self.N_O = [dict[@"NO"] intValue];
    self.THINGS_AREA = dict[@"THINGS_AREA"];
    self.THINGS_DES = dict[@"THINGS_DES"];
    self.THINGS_HEAD_IMAGE = dict[@"THINGS_HEAD_IMAGE"];
    self.THINGS_NAME = dict[@"THINGS_NAME"];
    self.THINGS_TEL_PHONE = dict[@"THINGS_TEL_PHONE"];
    self.THINGS_USER_NAME = dict[@"THINGS_USER_NAME"];
    self.THINGS_WANTS = dict[@"THINGS_WANTS"];
    self.THING_NEWS = dict[@"THING_NEWS"];

}

- (void)setExchangeDetailValueWithDict:(NSDictionary *)dict{
    self.EXCHANGE_TIME = [self objectOrNilForKey:@"exchangeTime" fromDictionary:dict];
    self.I_D = [[self objectOrNilForKey:@"id" fromDictionary:dict] intValue];
    self.THINGS_AREA = [self objectOrNilForKey:@"thingsArea" fromDictionary:dict];
    self.THINGS_DES = [self objectOrNilForKey:@"thingsDes" fromDictionary:dict];
    self.THINGS_HEAD_IMAGE = [self objectOrNilForKey:@"thingsHeadImage" fromDictionary:dict];
    self.THINGS_NAME = [self objectOrNilForKey:@"thingsName" fromDictionary:dict];
    self.THINGS_TEL_PHONE = [self objectOrNilForKey:@"thingsTelPhone" fromDictionary:dict];
    self.THINGS_USER_NAME = [self objectOrNilForKey:@"thingsUserName" fromDictionary:dict];
    self.THINGS_WANTS = [self objectOrNilForKey:@"thingsWants" fromDictionary:dict];
    self.THING_NEWS = [self objectOrNilForKey:@"thingNews" fromDictionary:dict];
}
#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
