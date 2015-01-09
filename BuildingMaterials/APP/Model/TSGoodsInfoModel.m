//
//  TSGoodsInfoModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/9.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSGoodsInfoModel.h"

@implementation TSGoodsInfoModel
- (void)setValueForDictionary:(NSDictionary *)dict{
    self.goodsClassifyId = [dict[@"goodsClassifyId"] intValue];
    self.goodsCompanyId = [dict[@"goodsCompanyId"] intValue];
    self.goodsDes = dict[@"goodsDes"];
    self.goodsDesSimple = dict[@"goodsDesSimple"] ? dict[@"goodsDesSimple"] : @"";
    self.goodsHeadImage = dict[@"goodsHeadImage"];
    self.goodsName = dict[@"goodsName"];
    self.goodsNewPrice = [dict[@"goodsNewPrice"] intValue];
    if (![dict[@"goodsOldPrice"] isEqual:[NSNull null]]) {
        self.goodsOldPrice = [dict[@"goodsOldPrice"] intValue];
    }
    
    self.goodsSellNumber = [dict[@"goodsSellNumber"] intValue];
    self.goodsWeight = [dict[@"goodsWeight"] intValue];
    self.goodsID = [dict[@"id"] intValue];
    self.isRecommend = [dict[@"isRecommend"] intValue];
    self.isUsed = [dict[@"isUsed"] intValue];
    self.recommendTime = dict[@"recommendTime"];

}
@end
