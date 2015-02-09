//
//  TSSecKillModel.h
//  BuildingMaterials
//
//  Created by Ariel on 14/12/31.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSSecKillModel : NSObject
@property (nonatomic, strong) NSString *GOODS_DES;
@property (nonatomic, strong) NSString *GOODS_HEAD_IMAGE;
@property (nonatomic, strong) NSString *GOODS_NAME;
@property (nonatomic, assign) int GOODS_NEW_PRICE;
@property (nonatomic, assign) int goodsId;   //商品ID
@property (nonatomic, assign) int SECKILL_PRICE;
@property (nonatomic, assign) int SECKILL_NUMBER;
@property (nonatomic, assign) int SECKILL_NUMBER_NOW;  //秒杀数量

@property (nonatomic, assign) int S_ID;

@property (nonatomic, strong) NSString *END_TIME;
@property (nonatomic, assign) int SecondsDeal_EventID;
@property (nonatomic, assign) int STATUS;


- (void)setValueForDictionary:(NSDictionary *)dict;
@end
