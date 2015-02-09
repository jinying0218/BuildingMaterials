//
//  TSOrderDetailViewModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/2/10.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSOrderDetailViewModel : NSObject
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int orderId;
@property (nonatomic, strong) NSString *orderStatus;

@property (nonatomic, strong) NSString *commentContentString;
@end
