//
//  TSImageModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/11.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSImageModel : NSObject
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) int image_ID;
@property (nonatomic, assign) int exchangeId;

- (void)setValueWithDict:(NSDictionary *)dict;
@end
