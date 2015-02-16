//
//  TSParametersList.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/10.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSParametersList : NSObject
@property (nonatomic, assign) int parametersId;
@property (nonatomic, strong) NSString *parametersName;

@property (nonatomic, strong) NSString *fatherParameterName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;

@end
