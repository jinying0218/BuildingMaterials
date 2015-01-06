//
//  TSGoodsExchangeViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/11/9.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSGoodsExchangeViewController.h"
#import "TSGoodsExchangeDetailTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "TSExchangeListModel.h"
#import "MJRefresh.h"
#import "TSExchangeModel.h"

static NSString *const GoodsExchangeDetailTableViewCell = @"GoodsExchangeDetailTableViewCell";

@interface TSGoodsExchangeViewController ()<UITableViewDelegate>
@property (nonatomic, strong) TSArrayDataSource *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int page;
@end

@implementation TSGoodsExchangeViewController
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - controller methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    [self initializeData];
    self.tabBarController.tabBar.hidden =  YES;
    [self setupUI];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)initializeData{
    
    NSDictionary *params = @{@"page":[NSString stringWithFormat:@"%d",self.page]};
    
    [TSHttpTool getWithUrl:Exchange_URL params:params withCache:NO success:^(id result) {
        NSLog(@"Exchange_URL:%@",result);
        if ([result objectForKey:@"success"]) {
            for (NSDictionary *oneExchangeDict in result[@"result"]) {
                TSExchangeListModel *exchangeModel = [[TSExchangeListModel alloc] init];
                [exchangeModel setValueForDictionary:oneExchangeDict];
                [self.viewModel.dataArray addObject:exchangeModel];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"以物换物：%@",error);
    }];
}
#pragma mark - set up UI
- (void)setupUI{
    
    [self creatRootView];
    [self createNavigationBarTitle:@"以物换物" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    [self.rootView addSubview:self.navigationBar];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KnaviBarHeight, KscreenW, KscreenH - KnaviBarHeight - STATUS_BAR_HEGHT) style:UITableViewStylePlain];
    self.tableView.rowHeight = 125;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    CellConfigureBlock configureBlock = ^(TSGoodsExchangeDetailTableViewCell *cell,TSExchangeListModel *model,NSIndexPath *indexPath){
        [cell configureCellWithModel:model indexPath:indexPath];
    };
    
    
    self.dataSource = [[TSArrayDataSource alloc] initWithNibName:@"TSGoodsExchangeDetailTableViewCell" items:self.viewModel.dataArray cellIdentifier:GoodsExchangeDetailTableViewCell configureCellBlock:configureBlock];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    [self.rootView addSubview:self.tableView];
    
    //集成上拉加载更多
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    self.tableView.footerPullToRefreshText = @"上拉加载更多";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    self.tableView.footerRefreshingText = @"加载中……";

}
#pragma mark - 上拉加载更多
- (void)footerRereshing{
    self.page += 1;
    NSDictionary *params = @{@"page":[NSString stringWithFormat:@"%d",self.page],
                             @"goodsOrderType":@"1"};

    [TSHttpTool getWithUrl:Exchange_URL params:params withCache:NO success:^(id result) {
        NSLog(@"Exchange_URL:%@",result);
        if ([result objectForKey:@"success"]) {
            for (NSDictionary *oneExchangeDict in result[@"result"]) {
                TSExchangeListModel *exchangeModel = [[TSExchangeListModel alloc] init];
                [exchangeModel setValueForDictionary:oneExchangeDict];
                [self.viewModel.dataArray addObject:exchangeModel];
            }
            [self.tableView reloadData];
            [self.tableView footerEndRefreshing];
        }
    } failure:^(NSError *error) {
        NSLog(@"以物换物：%@",error);
    }];
    
}

@end
