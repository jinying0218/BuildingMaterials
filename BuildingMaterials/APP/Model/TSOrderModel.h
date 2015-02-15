//
//  TSOrderModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/2/7.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSOrderModel : NSObject
@property (nonatomic, assign) int CC_ID;    //商家id
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, assign) int C_ID;
@property (nonatomic, strong) NSString *goodsHeadImageURL;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, assign) int goodsNumber;
@property (nonatomic, strong) NSString *goodsParameters;
@property (nonatomic, assign) float goodsWeight;
@property (nonatomic, assign) int G_ID;
@property (nonatomic, assign) float price;
@property (nonatomic, assign) int seckillId;

- (void)modelWithDict:(NSDictionary *)dict;
@end
