//
//  TSGoodsRecommandModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/3.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSGoodsRecommandModel : NSObject
@property (nonatomic, assign) int GOODS_CLASSIFY_ID;
@property (nonatomic, assign) int GOODS_COMPANY_ID;

@property (nonatomic, strong) NSString *GOODS_DES;
@property (nonatomic, strong) NSString *GOODS_DES_SIMPLE;
@property (nonatomic, strong) NSString *GOODS_HEAD_IMAGE;
@property (nonatomic, strong) NSString *GOODS_NAME;
@property (nonatomic, assign) int GOODS_NEW_PRICE;
@property (nonatomic, assign) int GOODS_OLD_PRICE;
@property (nonatomic, assign) int GOODS_SELL_NUMBER;
@property (nonatomic, assign) int GOODS_WEIGHT;
@property (nonatomic, assign) int I_D;
@property (nonatomic, assign) int IS_RECOMMEND;
@property (nonatomic, assign) int IS_USED;
@property (nonatomic, assign) int N_O;
@property (nonatomic, strong) NSString *RECOMMEND_TIME;

- (void)setValueForDictionary:(NSDictionary *)dict;

@end
