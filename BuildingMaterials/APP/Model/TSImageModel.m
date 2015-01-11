//
//  TSImageModel.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/11.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSImageModel.h"

@implementation TSImageModel
- (void)setValueWithDict:(NSDictionary *)dict{
    self.imageUrl = [self objectOrNilForKey:@"imageUrl" fromDictionary:dict];
    self.image_ID = [[self objectOrNilForKey:@"id" fromDictionary:dict] intValue];
    self.exchangeId = [[self objectOrNilForKey:@"exchangeId" fromDictionary:dict] intValue];
    
}


#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
