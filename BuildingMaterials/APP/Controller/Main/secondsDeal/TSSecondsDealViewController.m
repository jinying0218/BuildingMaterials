//
//  TSSecondsDealViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/11/1.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSSecondsDealViewController.h"

@interface TSSecondsDealViewController ()
@property (nonatomic, strong) TSArrayDataSource *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TSSecondsDealViewController
#pragma mark - controller methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - set up UI
- (void)setupUI{
    
    [self creatRootView];
    [self createNavigationBarTitle:@"掌上秒杀" leftButtonImageName:@"Previous" rightButtonImageName:nil];
//    [self.naviLeftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.rootView addSubview:self.navigationBar];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KnaviBarHeight, KscreenW, KscreenH - KnaviBarHeight - STATUS_BAR_HEGHT - KbottomBarHeight) style:UITableViewStylePlain];
    self.tableView.rowHeight = 68;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.rootView addSubview:self.tableView];
//    CellConfigureBlock configureBlock = ^(TSAdminTaskTableViewCell *cell,TSTaskModel *taskModel,NSIndexPath *indexPath){
//        [cell configureCell:taskModel indexPath:indexPath];
    
//    };

}
@end
