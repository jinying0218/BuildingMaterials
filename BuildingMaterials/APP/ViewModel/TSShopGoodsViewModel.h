//
//  TSShopGoodsViewModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/9.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSShopGoodsViewModel : NSObject
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int companyID;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSMutableArray *popDataArray;
@property (nonatomic, strong) NSMutableArray *categoryDataArray;
@property (nonatomic, strong) NSMutableArray *sortDataArray;
@property (nonatomic, assign) int classifyID;   //分类id
@property (nonatomic, strong) NSString *goodsOrderType;     //排序方式    1为默认  2为按价格  3为安人气

@end
