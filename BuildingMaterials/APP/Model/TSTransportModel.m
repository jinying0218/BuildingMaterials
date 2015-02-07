//
//  TSTransportModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/7.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSTransportModel.h"

@implementation TSTransportModel
- (void)modelWithDict:(NSDictionary *)dict{
    self.companyId = [[self objectOrNilForKey:@"companyId" fromDictionary:dict] intValue];
    self.tans_id = [[self objectOrNilForKey:@"id" fromDictionary:dict] intValue];
    self.status = [[self objectOrNilForKey:@"status" fromDictionary:dict] intValue];
    self.transportFee = [[self objectOrNilForKey:@"transportFee" fromDictionary:dict] intValue];
    self.transportFirstFee = [[self objectOrNilForKey:@"transportFirstFee" fromDictionary:dict] intValue];
    self.transportFirstWeight = [[self objectOrNilForKey:@"transportFirstWeight" fromDictionary:dict] intValue];
    self.transportName = [self objectOrNilForKey:@"transportName" fromDictionary:dict];
    self.transportOverFee = [[self objectOrNilForKey:@"transportOverFee" fromDictionary:dict] intValue];
    self.transportType = [[self objectOrNilForKey:@"transportType" fromDictionary:dict] intValue];

}
#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}
@end
