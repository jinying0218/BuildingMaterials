//
//  TSOrderDetailGoodsModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/2/10.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSOrderDetailGoodsModel : NSObject
@property (nonatomic, strong) NSString *goodsHeadImage;
@property (nonatomic, assign) int goodsId;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, assign) int goodsNumber;
@property (nonatomic, strong) NSString *goodsParameters;
@property (nonatomic, assign) int G_ID;     //用来做商品评价
@property (nonatomic, assign) int ID;
@property (nonatomic, assign) int orderId;
@property (nonatomic, assign) int orderGoodsPrice;

- (void)modelWithDict:(NSDictionary *)dict;

- (void)havePayModelWithDict:(NSDictionary *)dict;
@end
