//
//  TSCollectionShopModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSCollectionShopModel.h"

@implementation TSCollectionShopModel
- (void)setValueWithDict:(NSDictionary *)dict{
    self.collectionId = [[self objectOrNilForKey:@"COLLECTION_ID" fromDictionary:dict] intValue];
    self.C_ID = [[self objectOrNilForKey:@"C_ID" fromDictionary:dict] intValue];
    self.collectionCompanyDes = [self objectOrNilForKey:@"COMPANY_DES" fromDictionary:dict];
    self.collectionCompanyImageURL = [self objectOrNilForKey:@"COMPANY_DES" fromDictionary:dict];
    self.collectionCompanyName = [self objectOrNilForKey:@"COMPANY_DES" fromDictionary:dict];

}
#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}
@end
