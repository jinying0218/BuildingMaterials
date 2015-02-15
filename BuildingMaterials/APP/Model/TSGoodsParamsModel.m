//
//  TSGoodsParamsModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/9.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSGoodsParamsModel.h"

@implementation TSGoodsParamsModel
- (instancetype)init{
    self = [super init];
    if (self) {
        _parameterButtons = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)setValueWithDictionary:(NSDictionary *)dict{
    self.goodsParametersName = [self objectOrNilForKey:@"goodsParametersName" fromDictionary:dict];
    self.goodsParametersId = [[self objectOrNilForKey:@"goodsParametersId" fromDictionary:dict] intValue];
    
    NSObject *receivedParametersList = [dict objectForKey:@"parametersList"];
    NSMutableArray *parsedParametersList = [NSMutableArray array];
    if ([receivedParametersList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedParametersList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedParametersList addObject:[TSParametersList modelObjectWithDictionary:item]];
            }
        }
    }
    self.parametersList = [NSArray arrayWithArray:parsedParametersList];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
