//
//  TSCollectionShopModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSCollectionShopModel : NSObject
@property (nonatomic, assign) int collectionId;
@property (nonatomic, strong) NSString *collectionCompanyDes;
@property (nonatomic, strong) NSString *collectionCompanyImageURL;
@property (nonatomic, strong) NSString *collectionCompanyName;
@property (nonatomic, assign) int C_ID;

- (void)setValueWithDict:(NSDictionary *)dict;
@end
