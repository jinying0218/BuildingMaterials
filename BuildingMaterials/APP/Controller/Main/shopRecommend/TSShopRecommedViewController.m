//
//  TSShopRecommedViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/11/9.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSShopRecommedViewController.h"
#import "TSShopRecommedDetailTableViewCell.h"
#import "TSShopDetailViewController.h"
#import "TSShopDetailViewModel.h"
#import "MJRefresh.h"

#import "TSShopModel.h"


static NSString *const ShopRecommedDetailTableViewCell = @"ShopRecommedDetailTableViewCell";

@interface TSShopRecommedViewController ()<UITableViewDelegate>
@property (nonatomic, strong) TSArrayDataSource *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int page;

@end

@implementation TSShopRecommedViewController

#pragma mark - controller methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self initializeData];
    [self setupUI];
    
    self.tabBarController.tabBar.hidden =  YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)initializeData{
    
//http://www.d-anshun.com/appInterface/companyLoad
    NSDictionary *params = @{@"page":[NSString stringWithFormat:@"%d",self.page]};
    
    [TSHttpTool getWithUrl:CompanyLoad_URL params:params withCache:NO success:^(id result) {
        NSLog(@"商家列表:%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *oneExchangeDict in result[@"result"]) {
                TSShopModel *shopModel = [[TSShopModel alloc] init];
                [shopModel setValueForDictionary:oneExchangeDict];
                [self.viewModel.dataArray addObject:shopModel];
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
    [self createNavigationBarTitle:@"商家推荐" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    [self.rootView addSubview:self.navigationBar];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KnaviBarHeight, KscreenW, KscreenH - KnaviBarHeight - STATUS_BAR_HEGHT) style:UITableViewStylePlain];
    self.tableView.rowHeight = 100;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    CellConfigureBlock configureBlock = ^(TSShopRecommedDetailTableViewCell *cell,TSShopModel *taskModel,NSIndexPath *indexPath){
        [cell configureCellWithModel:taskModel indexPath:indexPath];
    };
    
    
    self.dataSource = [[TSArrayDataSource alloc] initWithNibName:@"TSShopRecommedDetailTableViewCell" items:self.viewModel.dataArray cellIdentifier:ShopRecommedDetailTableViewCell configureCellBlock:configureBlock];
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
    NSDictionary *params = @{@"page":[NSString stringWithFormat:@"%d",self.page]};
    
    [TSHttpTool getWithUrl:CompanyLoad_URL params:params withCache:NO success:^(id result) {
        NSLog(@"商家列表:%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *oneExchangeDict in result[@"result"]) {
                TSShopModel *shopModel = [[TSShopModel alloc] init];
                [shopModel setValueForDictionary:oneExchangeDict];
                [self.viewModel.dataArray addObject:shopModel];
            }
            [self.tableView reloadData];
            [self.tableView footerEndRefreshing];
        }
    } failure:^(NSError *error) {
        NSLog(@"以物换物：%@",error);
    }];
    
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TSShopModel *shopModel = self.viewModel.dataArray[indexPath.row];
    TSShopDetailViewModel *viewModel = [[TSShopDetailViewModel alloc] init];
    viewModel.companyID = shopModel.I_D;
    TSShopDetailViewController *shopDetailVC = [[TSShopDetailViewController alloc] initWithViewModel:viewModel];
    [self.navigationController pushViewController:shopDetailVC animated:YES];
}
@end
