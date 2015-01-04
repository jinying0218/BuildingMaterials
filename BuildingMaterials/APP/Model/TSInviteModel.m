//
//  TSInviteModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/4.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSInviteModel.h"

@implementation TSInviteModel
- (void)setValueForDictionary:(NSDictionary *)dict{
    self.COMPANY_ADDRESS = dict[@"COMPANY_ADDRESS"];
    self.COMPANY_ID = [dict[@"COMPANY_ID"] intValue];
    self.COMPANY_NAME = dict[@"COMPANY_NAME"];
    self.I_D = [dict[@"ID"] intValue];
    self.IS_USED = [dict[@"IS_USED"] intValue];
    self.N_O = [dict[@"NO"] intValue];
    self.POST_ASK_NUMBER = [dict[@"POST_ASK_NUMBER"] intValue];
    self.POST_CLASSIFY_ID = [dict[@"POST_CLASSIFY_ID"] intValue];
    self.POST_COMPANY_ID = [dict[@"POST_COMPANY_ID"] intValue];
    self.POST_DES = dict[@"POST_DES"];
    self.POST_NAME = dict[@"POST_NAME"];
    self.POST_NUMBER = [dict[@"POST_NUMBER"] intValue];
    self.POST_PRICE = [dict[@"POST_PRICE"] intValue];
    self.POST_TIME = dict[@"POST_TIME"];

}
@end
