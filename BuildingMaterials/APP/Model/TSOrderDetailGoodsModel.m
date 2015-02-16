//
//  TSOrderDetailGoodsModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/10.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSOrderDetailGoodsModel.h"

@implementation TSOrderDetailGoodsModel
/*
 @property (nonatomic, strong) NSString *goodsHeadImage;
 @property (nonatomic, assign) int goodsId;
 @property (nonatomic, strong) NSString *goodsName;
 @property (nonatomic, assign) int goodsNumber;
 @property (nonatomic, strong) NSString *goodsParameters;
 @property (nonatomic, assign) int G_ID;     //用来做商品评价
 @property (nonatomic, assign) int ID;
 @property (nonatomic, assign) int orderId;
 @property (nonatomic, assign) int orderGoodsPrice;

 */
- (void)modelWithDict:(NSDictionary *)dict{
    self.goodsHeadImage = [self objectOrNilForKey:@"GOODS_HEAD_IMAGE" fromDictionary:dict];
    self.goodsId = [[self objectOrNilForKey:@"GOODS_ID" fromDictionary:dict] intValue];
    self.goodsName = [self objectOrNilForKey:@"GOODS_NAME" fromDictionary:dict];
    self.goodsNumber = [[self objectOrNilForKey:@"GOODS_NUMBER" fromDictionary:dict] intValue];
    self.goodsParameters = [self objectOrNilForKey:@"GOODS_PARAMETERS" fromDictionary:dict];
    self.G_ID = [[self objectOrNilForKey:@"G_ID" fromDictionary:dict] intValue];
    self.ID = [[self objectOrNilForKey:@"ID" fromDictionary:dict] intValue];
    self.orderId = [[self objectOrNilForKey:@"ORDER_ID" fromDictionary:dict] intValue];
    self.orderGoodsPrice = [[self objectOrNilForKey:@"ORDER_GOODS_PRICE" fromDictionary:dict] floatValue];

}
- (void)havePayModelWithDict:(NSDictionary *)dict{
    self.goodsHeadImage = [self objectOrNilForKey:@"GOODS_IMAGE" fromDictionary:dict];
    self.goodsName = [self objectOrNilForKey:@"GOODS_NAME" fromDictionary:dict];
    self.goodsNumber = [[self objectOrNilForKey:@"GOODS_NUMBER" fromDictionary:dict] intValue];
    self.goodsParameters = [self objectOrNilForKey:@"GOODS_PARAMETERS" fromDictionary:dict];
    self.G_ID = [[self objectOrNilForKey:@"G_ID" fromDictionary:dict] intValue];
    self.orderGoodsPrice = [[self objectOrNilForKey:@"ORDER_GOODS_PRICE" fromDictionary:dict] floatValue];
}
#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
