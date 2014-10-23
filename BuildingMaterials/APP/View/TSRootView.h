//
//  TSRootView.h
//  RoutineInspection
//
//  Created by Aries on 14-8-21.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#import "TSBaseView.h"

@interface TSRootView : TSBaseView

@property (nonatomic, strong) UITableView *rootTableView;

- (void)setupRootTableView;
@end
