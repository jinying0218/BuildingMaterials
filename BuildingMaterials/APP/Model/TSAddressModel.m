//
//  TSAddressModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/21.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSAddressModel.h"

@implementation TSAddressModel
- (void)setValueWithDict:(NSDictionary *)dict{
    self.addressMain = [self objectOrNilForKey:@"addressMain" fromDictionary:dict];
    self.addressId = [[self objectOrNilForKey:@"id" fromDictionary:dict] intValue];
    self.userId = [[self objectOrNilForKey:@"userId" fromDictionary:dict] intValue];

}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
