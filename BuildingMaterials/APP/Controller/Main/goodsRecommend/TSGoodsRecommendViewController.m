//
//  TSGoodsRecommendViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/11/9.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSGoodsRecommendViewController.h"
#import "TSGoodsRecommadDetailTableViewCell.h"
#import "TSGoodsRecommandModel.h"
#import "MJRefresh.h"

static NSString *const GoodsRecommadDetailTableViewCell = @"GoodsRecommadDetailTableViewCell";

@interface TSGoodsRecommendViewController ()<UITableViewDelegate>
@property (nonatomic, strong) TSArrayDataSource *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int page;

@end

@implementation TSGoodsRecommendViewController
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
}

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
 ///////////
/*

    page  页数
    goodsSearchName  搜索名称
    goodsClassifyId  商品分类
    goodsOrderType  商品排列方式 1为默认  2为安人气  3为按价格
*/
    
    NSDictionary *params = @{@"page":[NSString stringWithFormat:@"%d",self.page],
                             @"goodsOrderType":@"1"};
    
    [TSHttpTool getWithUrl:GoodsLoad_URL params:params withCache:NO success:^(id result) {
//        NSLog(@"GoodsLoad_URL:%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *oneRecommendGoodsDict in result[@"result"]) {
                TSGoodsRecommandModel *goodsModel = [[TSGoodsRecommandModel alloc] init];
                [goodsModel setValueForDictionary:oneRecommendGoodsDict];
                [self.viewModel.dataArray addObject:goodsModel];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"商品推荐：%@",error);
    }];

}
#pragma mark - set up UI
- (void)setupUI{
    
    [self creatRootView];
    [self createNavigationBarTitle:@"商品推荐" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    [self.rootView addSubview:self.navigationBar];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KnaviBarHeight, KscreenW, KscreenH - KnaviBarHeight - STATUS_BAR_HEGHT) style:UITableViewStylePlain];
    self.tableView.rowHeight = 125;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    CellConfigureBlock configureBlock = ^(TSGoodsRecommadDetailTableViewCell *cell,TSGoodsRecommandModel *taskModel,NSIndexPath *indexPath){
        [cell configureCellWithModel:taskModel indexPath:indexPath];
    };
    
    
    self.dataSource = [[TSArrayDataSource alloc] initWithNibName:@"TSGoodsRecommadDetailTableViewCell" items:self.viewModel.dataArray cellIdentifier:GoodsRecommadDetailTableViewCell configureCellBlock:configureBlock];
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
    
    [TSHttpTool getWithUrl:GoodsLoad_URL params:params withCache:NO success:^(id result) {
        //        NSLog(@"GoodsLoad_URL:%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *oneRecommendGoodsDict in result[@"result"]) {
                TSGoodsRecommandModel *goodsModel = [[TSGoodsRecommandModel alloc] init];
                [goodsModel setValueForDictionary:oneRecommendGoodsDict];
                [self.viewModel.dataArray addObject:goodsModel];
            }
            [self.tableView reloadData];
            [self.tableView footerEndRefreshing];
        }
    } failure:^(NSError *error) {
        NSLog(@"商品推荐：%@",error);
    }];
    
}

@end
