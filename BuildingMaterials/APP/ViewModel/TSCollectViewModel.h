//
//  TSCollectViewModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/25.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSCollectViewModel : NSObject
@property (nonatomic, strong) NSMutableArray *goodsDataArray;
@property (nonatomic, strong) NSMutableArray *shopDataArray;

@property (nonatomic, assign) BOOL isGoodsCollect;
@end
