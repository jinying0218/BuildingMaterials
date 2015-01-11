//
//  TSGoodsRecommandViewModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/5.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSGoodsRecommandViewModel : NSObject
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *popDataArray;
@property (nonatomic, strong) NSMutableArray *categoryDataArray;
@property (nonatomic, strong) NSMutableArray *sortDataArray;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) int classifyID;
@property (nonatomic, strong) NSString *goodsOrderType;
@end
