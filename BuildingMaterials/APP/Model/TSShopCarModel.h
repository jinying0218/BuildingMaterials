//
//  TSShopCarModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSShopCarModel : NSObject
@property (nonatomic, strong) NSString *goods_head_imageURL;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, assign) int goods_number;
@property (nonatomic, assign) int goods_price;
@property (nonatomic, assign) int goods_id;

- (void)setValueWithDict:(NSDictionary *)dict;
@end
