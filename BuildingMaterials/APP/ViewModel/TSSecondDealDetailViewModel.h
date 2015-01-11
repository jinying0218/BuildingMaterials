//
//  TSSecondDealDetailViewModel.h
//  BuildingMaterials
//
//  Created by Ariel on 14/11/30.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSSecKillModel.h"

typedef void(^CellConfigureBlock)(id cell,id item,NSIndexPath *indexPath);

@interface TSSecondDealDetailViewModel : NSObject<UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *tableDataArray;
@property (nonatomic, strong) TSSecKillModel *secKillModel;

- (void)configureTableViewWithNibName:(NSString *)nibName cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(CellConfigureBlock)aConfigureCellBlock;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
