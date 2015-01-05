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
@end
