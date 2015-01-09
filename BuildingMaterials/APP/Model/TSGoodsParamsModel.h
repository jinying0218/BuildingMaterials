//
//  TSGoodsParamsModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/9.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSParametersList.h"

@interface TSGoodsParamsModel : NSObject
@property (nonatomic, strong) NSString *goodsParametersName;
@property (nonatomic, strong) NSArray *parametersList;
@property (nonatomic, assign) int goodsParametersId;

- (void)setValueWithDictionary:(NSDictionary *)dict;
@end
