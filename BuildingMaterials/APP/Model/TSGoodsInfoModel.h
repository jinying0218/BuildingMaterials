//
//  TSGoodsInfoModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/9.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSGoodsInfoModel : NSObject
@property (nonatomic, assign) int goodsClassifyId;
@property (nonatomic, assign) int goodsCompanyId;

@property (nonatomic, strong) NSString *goodsDes;
@property (nonatomic, strong) NSString *goodsDesSimple;
@property (nonatomic, strong) NSString *goodsHeadImage;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, assign) float goodsNewPrice;
@property (nonatomic, assign) float goodsOldPrice;
@property (nonatomic, assign) int goodsSellNumber;
@property (nonatomic, assign) float goodsWeight;
@property (nonatomic, assign) int goodsID;
@property (nonatomic, assign) int isRecommend;
@property (nonatomic, assign) int isUsed;
@property (nonatomic, strong) NSString *recommendTime;

- (void)setValueForDictionary:(NSDictionary *)dict;
@end
