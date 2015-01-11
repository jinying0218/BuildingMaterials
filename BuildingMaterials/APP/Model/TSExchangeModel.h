//
//  TSExchangeModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/3.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSExchangeModel : NSObject
@property (nonatomic, strong) NSString *THINGS_HEAD_IMAGE;
@property (nonatomic, strong) NSString *THINGS_DES;
@property (nonatomic, strong) NSString *THINGS_NAME;
@property (nonatomic, strong) NSString *THINGS_TEL_PHONE;
@property (nonatomic, strong) NSString *N_O;
@property (nonatomic, strong) NSString *EXCHANGE_TIME;
@property (nonatomic, strong) NSString *THINGS_USER_NAME;
@property (nonatomic, strong) NSString *THINGS_AREA;
@property (nonatomic, strong) NSString *THINGS_WANTS;

@property (nonatomic, assign) int I_D;
@property (nonatomic, strong) NSString *THING_NEWS;

- (void)setValueWithDict:(NSDictionary *)dict;
@end
