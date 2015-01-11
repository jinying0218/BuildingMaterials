//
//  TSExchangeDetailViewModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/11.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSExchangeListModel.h"

@interface TSExchangeDetailViewModel : NSObject
@property (nonatomic, strong) TSExchangeListModel *exchangeGoodsModel;
@property (nonatomic, strong) NSMutableArray *imageArray;

@end
