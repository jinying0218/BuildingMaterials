//
//  TSInvitePostModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/6.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSInvitePostModel.h"

@implementation TSInvitePostModel
- (void)setValueForDictionary:(NSDictionary *)dict{
    self.companyId = [dict[@"companyId"] intValue];
    self.post_id = [dict[@"post_id"] intValue];
    self.isUsed = [dict[@"isUsed"] intValue];
    self.postAskNumber = [dict[@"postAskNumber"] intValue];
    self.postClassifyId = [dict[@"postClassifyId"] intValue];
    self.postCompanyId = [dict[@"postCompanyId"] intValue];
    self.postDes = dict[@"postDes"];
    self.postName = dict[@"postName"];
    self.postNumber = [dict[@"postNumber"] intValue];
    self.postPrice = [dict[@"postPrice"] intValue];
    self.postTime = dict[@"postTime"];

}
@end
