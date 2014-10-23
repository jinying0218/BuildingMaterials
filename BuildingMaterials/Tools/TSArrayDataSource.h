//
//  TSArrayDataSource.h
//  RoutineInspection
//
//  Created by Aries on 14-8-21.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

typedef void(^CellConfigureBlock)(id cell,id item,NSIndexPath *indexPath);

#import <Foundation/Foundation.h>

@interface TSArrayDataSource : NSObject<UITableViewDataSource>
- (id)initWithNibName:(NSString *)nibName items:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(CellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
