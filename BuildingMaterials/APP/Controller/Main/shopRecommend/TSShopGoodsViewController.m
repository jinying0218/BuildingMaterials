//
//  TSShopGoodsViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/9.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSShopGoodsViewController.h"
#import "TSGoodsRecommadDetailTableViewCell.h"
#import "TSGoodsRecommandModel.h"
#import "MJRefresh.h"

#import "TSGoodsDetailViewController.h"
#import "TSGoodsDetailViewModel.h"
#import "TSInviteCategoryCell.h"
#import "TSCategoryModel.h"

#define GoodsTableViewTag 3000
#define PopTableViewTag 3001

static NSString *const GoodsRecommadDetailTableViewCell = @"GoodsRecommadDetailTableViewCell";
static NSString *const popTableViewCell = @"popTableViewCell";

@interface TSShopGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) TSArrayDataSource *dataSource;
@property (nonatomic, strong) UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UIButton *sortButton;
@property (strong, nonatomic) UITableView *popTableView;
@property (nonatomic, strong) UIView *coverTop;
@property (nonatomic, strong) UIView *coverBottom;

@property (nonatomic, assign) BOOL isSort;

@end

@implementation TSShopGoodsViewController

#pragma mark - controller methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden =  YES;

    [self initializeData];
    [self setupUI];
    [self blindActionHandler];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initializeData{
    
    NSDictionary *params;
    //如果是全部分类
    if (self.viewModel.classifyID == 0) {
        params =  @{@"page" : [NSString stringWithFormat:@"%d",self.viewModel.page],
                    @"goodsOrderType": self.viewModel.goodsOrderType,
                    @"companyId" : [NSString stringWithFormat:@"%d",self.viewModel.companyID]};
        
    }else {
        params = @{@"page":[NSString stringWithFormat:@"%d",self.viewModel.page],
                   @"goodsOrderType" : self.viewModel.goodsOrderType,
                   @"goodsClassifyId" : [NSString stringWithFormat:@"%d",self.viewModel.classifyID],
                   @"companyId" : [NSString stringWithFormat:@"%d",self.viewModel.companyID]};
    }

    [self getCompanyGoods:params];
    
    NSDictionary *classifyParams = @{@"companyId" : [NSString stringWithFormat:@"%d",self.viewModel.companyID]};
    
    [TSHttpTool getWithUrl:CompanyGoodsClassifyLoad_URL params:classifyParams withCache:NO success:^(id result) {
//                NSLog(@"商品分类:%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *oneResult in result[@"result"]) {
                TSCategoryModel *model = [[TSCategoryModel alloc] init];
                [model modelWithDictionary:oneResult];
                [self.viewModel.categoryDataArray addObject:model];
            }
            TSCategoryModel *model = [[TSCategoryModel alloc] init];
            model.classifyName = @"全部";
            [self.viewModel.categoryDataArray insertObject:model atIndex:0];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"商品分类:%@",error);
    }];

    NSArray *sortArray = @[@"默认",@"价格",@"人气"];
    int i = 1;
    for (NSString *string in sortArray) {
        TSCategoryModel *model = [[TSCategoryModel alloc] init];
        model.classifyName = string;
        model.classifyID = i;   //排序id   1.2.3
        i ++;
        [self.viewModel.sortDataArray addObject:model];
    }
}

- (void)getCompanyGoods:(NSDictionary *)params{
    
    [TSHttpTool getWithUrl:CompanyGoodsLoad_URL params:params withCache:NO success:^(id result) {
        NSLog(@"商家商品:%@",result);
        if ([result[@"success"] intValue] == 1) {
            [self.viewModel.dataArray removeAllObjects];
            for (NSDictionary *oneRecommendGoodsDict in result[@"result"]) {
                TSGoodsRecommandModel *goodsModel = [[TSGoodsRecommandModel alloc] init];
                [goodsModel setValueForDictionary:oneRecommendGoodsDict];
                [self.viewModel.dataArray addObject:goodsModel];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"商家商品：%@",error);
    }];
}

#pragma mark - set up UI
- (void)setupUI{
    
    [self createNavigationBarTitle:self.viewModel.companyName leftButtonImageName:@"Previous" rightButtonImageName:nil];
    [self.view addSubview:self.navigationBar];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    
    UIView *searchBg = [[UIView alloc] initWithFrame:CGRectMake( 60, 8, KscreenW - 120, 28)];
    searchBg.backgroundColor = [UIColor whiteColor];
    searchBg.layer.cornerRadius = 5;
    [self.navigationBar addSubview:searchBg];
    
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"search_leftView"]];
    leftView.frame = CGRectMake( 10, 6, 15, 15);
    [searchBg addSubview:leftView];
    
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake( CGRectGetMaxX(leftView.frame) + 10, 0, searchBg.frame.size.width - 40, 28)];
    self.searchTextField.placeholder = @"请输入商品关键字";
    self.searchTextField.backgroundColor = [UIColor clearColor];
    [searchBg addSubview:self.searchTextField];
    
    self.naviRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.naviRightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.naviRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.naviRightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    self.naviRightBtn.frame = CGRectMake( CGRectGetMaxX(searchBg.frame), 12, 60, 20);
    [self.navigationBar addSubview:self.naviRightBtn];

    
    
    self.tableView.rowHeight = 115;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    CellConfigureBlock configureBlock = ^(TSGoodsRecommadDetailTableViewCell *cell,TSGoodsRecommandModel *taskModel,NSIndexPath *indexPath){
        [cell configureCellWithModel:taskModel indexPath:indexPath];
    };
    
    
    self.dataSource = [[TSArrayDataSource alloc] initWithNibName:@"TSGoodsRecommadDetailTableViewCell" items:self.viewModel.dataArray cellIdentifier:GoodsRecommadDetailTableViewCell configureCellBlock:configureBlock];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    
    self.tableView.tag = GoodsTableViewTag;
    self.popTableView.tag = PopTableViewTag;
    
    //集成上拉加载更多
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    self.tableView.footerPullToRefreshText = @"上拉加载更多";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    self.tableView.footerRefreshingText = @"加载中……";
    
    
    self.coverTop = [[UIView alloc] init];
    self.coverTop.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    self.coverTop.backgroundColor = [UIColor blackColor];
    self.coverTop.alpha = 0.5;
    self.coverTop.hidden = YES;
    [self.view addSubview:self.coverTop];
    
    self.coverBottom = [[UIView alloc] init];
    self.coverBottom.frame = CGRectMake( 0, 79 + STATUS_BAR_HEGHT, KscreenW, KscreenH);
    self.coverBottom.backgroundColor = [UIColor blackColor];
    self.coverBottom.alpha = 0.5;
    self.coverBottom.hidden = YES;
    [self.view addSubview:self.coverBottom];
    
    
    self.popTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 79 + STATUS_BAR_HEGHT, KscreenW, 44 * 5) style:UITableViewStylePlain];
    self.popTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.popTableView.rowHeight = 44;
    self.popTableView.tag = PopTableViewTag;
    [self.view addSubview:self.popTableView];
    
    self.popTableView.delegate = self;
    self.popTableView.dataSource = self;
    self.popTableView.showsVerticalScrollIndicator = NO;
    self.popTableView.hidden = YES;

}

#pragma mark - blind methods

- (void)blindActionHandler{
    @weakify(self);
    //搜索按钮
    [self.naviRightBtn bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.viewModel.page = 1;

        NSDictionary *params = @{@"page":[NSString stringWithFormat:@"%d",self.viewModel.page],
                   @"goodsOrderType" : self.viewModel.goodsOrderType,
                   @"goodsClassifyId" : [NSString stringWithFormat:@"%d",self.viewModel.classifyID],
                   @"companyId" : [NSString stringWithFormat:@"%d",self.viewModel.companyID],
                   @"goodsSearchName" : self.searchTextField.text};

        [self getCompanyGoods:params];
        
    } forControlEvents:UIControlEventTouchUpInside];
    //类别
    [self.categoryButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.viewModel.popDataArray = self.viewModel.categoryDataArray;
        self.popTableView.hidden = !self.popTableView.hidden;
        self.coverBottom.hidden = !self.coverBottom.hidden;
        self.coverTop.hidden = !self.coverTop.hidden;
        self.isSort = NO;
        [self.popTableView reloadData];
    } forControlEvents:UIControlEventTouchUpInside];
    //排序
    [self.sortButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.viewModel.popDataArray = self.viewModel.sortDataArray;
        self.popTableView.hidden = !self.popTableView.hidden;
        self.coverBottom.hidden = !self.coverBottom.hidden;
        self.coverTop.hidden = !self.coverTop.hidden;
        self.isSort = YES;
        [self.popTableView reloadData];
    } forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 上拉加载更多
- (void)footerRereshing{
    self.viewModel.page += 1;
    
    NSDictionary *params = nil;
    if (self.viewModel.classifyID == 0) {
        params =  @{@"page" : [NSString stringWithFormat:@"%d",self.viewModel.page],
                    @"goodsOrderType": self.viewModel.goodsOrderType,
                    @"companyId" : [NSString stringWithFormat:@"%d",self.viewModel.companyID]};
    }else {
        params = @{@"page":[NSString stringWithFormat:@"%d",self.viewModel.page],
                   @"goodsOrderType" : self.viewModel.goodsOrderType,
                   @"goodsClassifyId" : [NSString stringWithFormat:@"%d",self.viewModel.classifyID],
                   @"companyId" : [NSString stringWithFormat:@"%d",self.viewModel.companyID]};
    }

    [TSHttpTool getWithUrl:CompanyGoodsLoad_URL params:params withCache:NO success:^(id result) {
//        NSLog(@"商家商品:%@",result);
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
        NSLog(@"商家商品：%@",error);
    }];
}

#pragma mark - tableView delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.popDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TSInviteCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:popTableViewCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSInviteCategoryCell" owner:nil options:nil]lastObject];
    }
    
    TSCategoryModel *model = self.viewModel.popDataArray[indexPath.row];
    cell.categoryDes.text = model.classifyName;
    
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //选择类别
    if (tableView.tag == PopTableViewTag) {
        self.popTableView.hidden = YES;
        self.coverBottom.hidden = YES;
        self.coverTop.hidden = YES;
        self.viewModel.page = 1;
        
        [self getCategoryDataWithIndexPath:indexPath];
    }else {
        TSGoodsRecommandModel *goodsModel = self.viewModel.dataArray[indexPath.row];
        TSGoodsDetailViewModel *viewModel = [[TSGoodsDetailViewModel alloc] init];
        viewModel.goodsID = goodsModel.I_D;
        TSGoodsDetailViewController *goodsDetailVC = [[TSGoodsDetailViewController alloc] init];
        goodsDetailVC.viewModel = viewModel;
        [self.navigationController pushViewController:goodsDetailVC animated:YES];
 
    }
}

#pragma mark - helper
- (void)getCategoryDataWithIndexPath:(NSIndexPath *)indexPath {
    
    TSCategoryModel *categoryModel = self.viewModel.popDataArray[indexPath.row];
    NSDictionary *params;
    
    //如果按照当前排序
    if (self.isSort) {
        self.viewModel.goodsOrderType = [NSString stringWithFormat:@"%d",categoryModel.classifyID];
        [self.sortButton setTitle:categoryModel.classifyName forState:UIControlStateNormal];
        
        if (self.viewModel.classifyID == 0) {
            params =  @{@"page" : [NSString stringWithFormat:@"%d",self.viewModel.page],
                        @"goodsOrderType": self.viewModel.goodsOrderType,
                        @"companyId" : [NSString stringWithFormat:@"%d",self.viewModel.companyID]};
            
        }else {
            params = @{@"page":[NSString stringWithFormat:@"%d",self.viewModel.page],
                       @"goodsOrderType" : self.viewModel.goodsOrderType,
                       @"goodsClassifyId" : [NSString stringWithFormat:@"%d",self.viewModel.classifyID],
                       @"companyId" : [NSString stringWithFormat:@"%d",self.viewModel.companyID]};
        }
    }else {
        [self.categoryButton setTitle:categoryModel.classifyName forState:UIControlStateNormal];
        
        //按照默认排序
        if (indexPath.row == 0) {
            self.viewModel.classifyID = 0;
            params =  @{@"page" : [NSString stringWithFormat:@"%d",self.viewModel.page],
                        @"goodsOrderType": self.viewModel.goodsOrderType,
                        @"companyId" : [NSString stringWithFormat:@"%d",self.viewModel.companyID]};

        }else {
            self.viewModel.classifyID = categoryModel.classifyID;
            params = @{@"page":[NSString stringWithFormat:@"%d",self.viewModel.page],
                       @"goodsOrderType" : self.viewModel.goodsOrderType,
                       @"goodsClassifyId" : [NSString stringWithFormat:@"%d",self.viewModel.classifyID],
                       @"companyId" : [NSString stringWithFormat:@"%d",self.viewModel.companyID]};

        }
        
    }
    
    [self getCompanyGoods:params];
}

@end
