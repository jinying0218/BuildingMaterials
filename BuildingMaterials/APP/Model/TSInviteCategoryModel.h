//
//  TSInviteCategoryModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/4.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSInviteCategoryModel : NSObject
@property (nonatomic, strong) NSString *postClassifyName;
@property (nonatomic, assign) int categoryID;
//@property (nonatomic, strong) NSString *categoryID;

- (void)setValueForDictionary:(NSDictionary *)dict;


@end
