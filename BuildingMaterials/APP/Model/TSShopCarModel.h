//
//  TSShopCarModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSShopCarModel : NSObject
@property (nonatomic, assign) int CC_ID;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, assign) int C_ID;

@property (nonatomic, strong) NSString *goods_head_imageURL;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, assign) int goods_number;
@property (nonatomic, assign) int goods_price;
@property (nonatomic, assign) int goods_id;
@property (nonatomic, strong) NSString *parameters;


- (void)setValueWithDict:(NSDictionary *)dict;
@end