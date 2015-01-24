//
//  TSCollectModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSCollectModel : NSObject
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
