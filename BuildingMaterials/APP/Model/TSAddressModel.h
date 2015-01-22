//
//  TSAddressModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/21.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSAddressModel : NSObject
@property (nonatomic, strong) NSString *addressMain;
@property (nonatomic, assign) int addressId;
@property (nonatomic, assign) int userId;

- (void)setValueWithDict:(NSDictionary *)dict;
@end
