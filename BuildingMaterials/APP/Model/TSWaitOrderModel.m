//
//  TSWaitOrderModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/10.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSWaitOrderModel.h"
#import "TSOrderDetailGoodsModel.h"

@implementation TSWaitOrderModel

- (void)modelWithDict:(NSDictionary *)dict{
    self.companyName = [self objectOrNilForKey:@"COMPANY_NAME" fromDictionary:dict];
    self.orderCode = [self objectOrNilForKey:@"ORDER_CODE" fromDictionary:dict];
    self.orderStatus = [self objectOrNilForKey:@"ORDER_STATUS" fromDictionary:dict];
    self.orderSureTime = [self objectOrNilForKey:@"ORDER_SURE_TIME" fromDictionary:dict];
    self.orderTotalPrice = [[self objectOrNilForKey:@"ORDER_TOTAL_PRICE" fromDictionary:dict] floatValue];
    self.transportCode = [self objectOrNilForKey:@"ORDER_TRANSPORT_CODE" fromDictionary:dict];
    self.transportName = [self objectOrNilForKey:@"ORDER_TRANSPORT_NAME" fromDictionary:dict];
    self.transportPrice = [[self objectOrNilForKey:@"ORDER_TRANSPORT_PRICE" fromDictionary:dict] floatValue];
    self.orderId = [[self objectOrNilForKey:@"O_ID" fromDictionary:dict] intValue];
    self.goods = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *goodDict in [self objectOrNilForKey:@"goods" fromDictionary:dict]) {
        TSOrderDetailGoodsModel *goodsModel = [[TSOrderDetailGoodsModel alloc] init];
        [goodsModel havePayModelWithDict:goodDict];
        [self.goods addObject:goodsModel];
    }
//    self.goods = [self objectOrNilForKey:@"goods" fromDictionary:dict];
}
#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
