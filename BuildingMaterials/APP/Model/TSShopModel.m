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
    
    self.COMPANY_ADDRESS = dict[@"companyAddress"];
    self.COMPANY_CONTACT = dict[@"companyContact"];
    self.COMPANY_DES = dict[@"companyDes"] ? dict[@"companyDes"] : @"";
    self.COMPANY_IMAGE_URL = dict[@"companyImageUrl"];
    self.COMPANY_NAME = dict[@"companyName"] ? dict[@"companyName"] : @"";
    self.COMPANY_TEL_PHONE = dict[@"companyTelPhone"];
    self.I_D = [dict[@"id"] intValue];
    self.IS_RECOMMEND = [dict[@"isRecommend"] intValue];
    self.RECOMMEND_TIME = dict[@"recommendTime"];

}
@end
