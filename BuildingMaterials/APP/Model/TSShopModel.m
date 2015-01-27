//
//  TSShopModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/3.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSShopModel.h"

@implementation TSShopModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (void)setValueForDictionary:(NSDictionary *)dict{
    self.COMPANY_ADDRESS = dict[@"COMPANY_ADDRESS"];
    self.COMPANY_CONTACT = dict[@"COMPANY_CONTACT"];
    self.COMPANY_DES = dict[@"COMPANY_DES"];
    self.COMPANY_IMAGE_URL = dict[@"COMPANY_IMAGE_URL"];
    self.COMPANY_NAME = dict[@"COMPANY_NAME"];
    self.COMPANY_TEL_PHONE = dict[@"COMPANY_TEL_PHONE"];
    self.I_D = [dict[@"ID"] intValue];
    self.IS_RECOMMEND = [dict[@"IS_RECOMMEND"] intValue];
    self.N_O = [dict[@"NO"] intValue];
    self.RECOMMEND_TIME = dict[@"RECOMMEND_TIME"];
}
- (void)setShopModelValueForDictionary:(NSDictionary *)dict{
    
    self.COMPANY_ADDRESS = [self objectOrNilForKey:@"companyAddress" fromDictionary:dict];
    self.COMPANY_CONTACT = [self objectOrNilForKey:@"companyContact" fromDictionary:dict];
    self.COMPANY_DES = [self objectOrNilForKey:@"companyDes" fromDictionary:dict];
    self.COMPANY_IMAGE_URL = [self objectOrNilForKey:@"companyImageUrl" fromDictionary:dict];
    self.COMPANY_NAME = [self objectOrNilForKey:@"companyName" fromDictionary:dict];
    self.COMPANY_TEL_PHONE = [self objectOrNilForKey:@"companyTelPhone" fromDictionary:dict];
    self.I_D = [[self objectOrNilForKey:@"id" fromDictionary:dict] intValue];
    self.IS_RECOMMEND = [[self objectOrNilForKey:@"isRecommend" fromDictionary:dict] intValue];
    self.RECOMMEND_TIME = [self objectOrNilForKey:@"recommendTime" fromDictionary:dict];

}
#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


@end
