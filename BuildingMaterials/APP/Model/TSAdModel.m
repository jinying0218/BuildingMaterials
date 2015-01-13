//
//  TSAdModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/13.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSAdModel.h"

@implementation TSAdModel

- (void)setValueWithDict:(NSDictionary *)dict{
    self.ad_go_ID = [[self objectOrNilForKey:@"AD_GO_ID" fromDictionary:dict] intValue];
    self.ad_showType = [self objectOrNilForKey:@"AD_SHOW_TYPE" fromDictionary:dict];
    self.ad_title = [self objectOrNilForKey:@"AD_TITLE" fromDictionary:dict];
    self.ad_type = [self objectOrNilForKey:@"AD_TYPE" fromDictionary:dict];
    self.ad_url = [self objectOrNilForKey:@"AD_URL" fromDictionary:dict];
    self.company_ID = [[self objectOrNilForKey:@"COMPANY_ID" fromDictionary:dict] intValue];
    self.ad_ID = [[self objectOrNilForKey:@"ID" fromDictionary:dict] intValue];

}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
