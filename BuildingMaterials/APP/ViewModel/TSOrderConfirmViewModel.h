//
//  TSOrderConfirmViewModel.h
//  BuildingMaterials
//
//  Created by Ariel on 15/1/31.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSOrderConfirmViewModel : NSObject
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *transportsArray;      //选择运送方式弹出框的数据源
@property (nonatomic, strong) NSMutableArray *subviewModels;    //分组viewModel

@property (nonatomic, assign) NSUInteger currentSection;    //记录当前选择运送方式的cell
@property (nonatomic, strong) NSString *address;

@end
