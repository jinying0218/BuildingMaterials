//
//  TSShopModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/3.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSShopModel : NSObject
@property (nonatomic, strong) NSString *COMPANY_ADDRESS;
@property (nonatomic, strong) NSString *COMPANY_CONTACT;
@property (nonatomic, strong) NSString *COMPANY_DES;
@property (nonatomic, strong) NSString *COMPANY_IMAGE_URL;
@property (nonatomic, strong) NSString *COMPANY_NAME;
@property (nonatomic, strong) NSString *COMPANY_TEL_PHONE;
@property (nonatomic, strong) NSString *RECOMMEND_TIME;
@property (nonatomic, assign) int I_D;
@property (nonatomic, assign) int IS_RECOMMEND;
@property (nonatomic, assign) int N_O;

- (void)setValueForDictionary:(NSDictionary *)dict;
- (void)setShopModelValueForDictionary:(NSDictionary *)dict;

@end
