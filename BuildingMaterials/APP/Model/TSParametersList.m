//
//  TSParametersList.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/10.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSParametersList.h"

NSString *const kParametersListParametersId = @"parametersId";
NSString *const kParametersListParametersName = @"parametersName";

@implementation TSParametersList
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.parametersId = [[self objectOrNilForKey:kParametersListParametersId fromDictionary:dict] doubleValue];
        self.parametersName = [self objectOrNilForKey:kParametersListParametersName fromDictionary:dict];
        
    }
    
    return self;
    
}
#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


@end
