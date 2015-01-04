//
//  TSCategoryModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/4.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSCategoryModel : NSObject
@property (nonatomic, strong) NSString *classifyDes;
@property (nonatomic, strong) NSString *classifyImageUrl;
@property (nonatomic, strong) NSString *classifyName;
@property (nonatomic, assign) int classifyID;

- (void)setValueForDictionary:(NSDictionary *)dict;
@end
