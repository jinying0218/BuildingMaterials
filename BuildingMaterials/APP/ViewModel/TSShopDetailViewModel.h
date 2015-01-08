//
//  TSShopDetailViewModel.h
//  BuildingMaterials
//
//  Created by Ariel on 14/12/17.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSShopModel.h"

@interface TSShopDetailViewModel : NSObject
@property (nonatomic, assign) int companyID;
@property (nonatomic, strong) TSShopModel *shopModel;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
