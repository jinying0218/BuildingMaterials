//
//  TSGoodsImageModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/2/13.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSGoodsImageModel : NSObject
@property (nonatomic, assign) int goodsId;
@property (nonatomic, assign) int goodsImageId;
@property (nonatomic, assign) int isHead;

@property (nonatomic, strong) NSString *imageDes;
@property (nonatomic, strong) NSString *imageUrl;

- (void)modelWithDict:(NSDictionary *)dict;
@end
