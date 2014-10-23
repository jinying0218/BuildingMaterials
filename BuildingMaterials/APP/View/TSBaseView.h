//
//  TSBaseView.h
//  RoutineInspection
//
//  Created by Aries on 14-8-21.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSArrayDataSource.h"
#import "TSItemClickDelegate.h"

@protocol  TSItemClickDelegate;

@interface TSBaseView : UIView<UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *arrayDataSource;
@property (nonatomic, assign) id<TSItemClickDelegate>delegate;

- (void)setupTableView:(UITableView *)tableView nibName:(NSString *)nibName dataSourceArray:(NSArray *)arrayDataSource cellIdentifier:(NSString *)cellIdentifier cellConfigureBlock:(CellConfigureBlock)configureCellBlock;
- (void)setupBottomView;

- (void)showProgressHUD:(NSString *)content delay:(double)delaySeconds;
- (void)showProgressHUD;
- (void)hideProgressHUD;
@end
