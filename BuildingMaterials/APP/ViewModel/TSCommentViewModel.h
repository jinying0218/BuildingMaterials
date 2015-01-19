//
//  TSCommentViewModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/16.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSGoodsInfoModel.h"

@interface TSCommentViewModel : NSObject
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *allComments;
@property (nonatomic, strong) TSGoodsInfoModel *goodsInfoModel;

@end
