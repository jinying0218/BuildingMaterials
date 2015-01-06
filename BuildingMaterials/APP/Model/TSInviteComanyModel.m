//
//  TSInviteComanyModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/7.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSInviteComanyModel.h"

@implementation TSInviteComanyModel
- (void)setValueForDictionary:(NSDictionary *)dict{
    self.companyAddress = dict[@"companyAddress"];
    self.companyContact = dict[@"companyContact"];
    self.companyDes = dict[@"companyDes"];
    self.companyImageUrl = dict[@"companyImageUrl"];
    self.companyName = dict[@"companyName"];
    self.companyTelPhone = dict[@"companyTelPhone"];
    self.company_Id = [dict[@"id"] intValue];
    self.isRecommend = [dict[@"isRecommend"] intValue];
    self.recommendTime = dict[@"recommendTime"];

}
@end
