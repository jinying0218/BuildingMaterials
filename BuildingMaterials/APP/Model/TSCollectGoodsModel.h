//
//  TSCollectModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSCollectGoodsModel : NSObject
@property (nonatomic, assign) int collectiong_id;
@property (nonatomic, assign) int c_id;
@property (nonatomic, assign) int goods_classify_id;
@property (nonatomic, assign) int goods_company_id;
@property (nonatomic, strong) NSString *goods_des;
@property (nonatomic, strong) NSString *goods_des_simple;
@property (nonatomic, strong) NSString *goods_Head_ImageUrl;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, assign) int goods_new_price;
@property (nonatomic, assign) int goods_old_price;
@property (nonatomic, assign) int goods_sell_number;
@property (nonatomic, assign) int goods_weight;
@property (nonatomic, assign) int Collect_id;
@property (nonatomic, assign) int is_recommend;
@property (nonatomic, assign) int is_used;
@property (nonatomic, strong) NSString *recomment_time;

- (void)setValueWithDict:(NSDictionary *)dict;

@end

/*
 GOODS_HEAD_IMAGE 商品图片地址
 GOODS_NAME 商品名称
 GOODS_DES_SIMPLE 商品描述
 GOODS_NEW_PRICE 商品价格
 C_ID  收藏id用来做删除收藏用的
 COLLECTION_ID  商品的Id  用来点击跳转到商品详情也用的id
 company  商家对象数组
 COMPANY_IMAGE_URL 商家图片
 COMPANY_NAME 商家名称
 COMPANY_DES 商家描述
 C_ID 收藏id 用来做删除收藏用的
 COLLECTION_ID  商家id 用来做跳转到商家详情页用的
 */