//
//  TSCategoryViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/24.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSCategoryViewController.h"
#import <UIImageView+WebCache.h>
#import "TSCategoryCell.h"
#import "TSCategoryModel.h"

#import "TSGoodsRecommendViewController.h"
#import "TSGoodsRecommandViewModel.h"

static NSString * const categoryCellIdentifier = @"categoryCell";     

@interface TSCategoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *categrayTable;
@property (nonatomic, strong) UITextField *searchTextField;

@end

@implementation TSCategoryViewController
#pragma mark - controller method
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializData];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - initializData
- (void)initializData{
    
    [TSHttpTool getWithUrl:Category_URL params:nil withCache:NO success:^(id result) {
        NSLog(@"分类:%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *oneResult in result[@"result"]) {
                TSCategoryModel *model = [[TSCategoryModel alloc] init];
                [model setValueForDictionary:oneResult];
                [self.viewModel.dataArray addObject:model];
            }
            [self.categrayTable reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"分类:%@",error);
    }];

}
#pragma mark - set UI
- (void)setupUI{
    
    [self creatRootView];
    self.navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, KnaviBarHeight)];
    self.navigationBar.backgroundColor = [UIColor colorWithHexString:@"#1CA6DF"];
    self.navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.rootView addSubview:self.navigationBar];
    
    UIView *searchBg = [[UIView alloc] initWithFrame:CGRectMake( 10, 8, KscreenW - 80, 28)];
    searchBg.backgroundColor = [UIColor whiteColor];
    searchBg.layer.cornerRadius = 5;
    [self.navigationBar addSubview:searchBg];
    
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"search_leftView"]];
    leftView.frame = CGRectMake( 10, 4, 20, 20);
    [searchBg addSubview:leftView];
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake( CGRectGetMaxX(leftView.frame) + 10, 0, searchBg.frame.size.width - 40, 28)];
    self.searchTextField.placeholder = @"请输入材料商品关键字";
    self.searchTextField.backgroundColor = [UIColor clearColor];
    [searchBg addSubview:self.searchTextField];
    
    UIButton *naviRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [naviRightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [naviRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [naviRightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    naviRightBtn.frame = CGRectMake( CGRectGetMaxX(searchBg.frame) + 10, 12, 60, 20);
    [self.navigationBar addSubview:naviRightBtn];
    
    [naviRightBtn bk_addEventHandler:^(id sender) {
        
    } forControlEvents:UIControlEventTouchUpInside];

    
    self.categrayTable = [[UITableView alloc] initWithFrame:CGRectMake( 0, KnaviBarHeight, KscreenW, KscreenH - KnaviBarHeight - KbottomBarHeight - STATUS_BAR_HEGHT) style:UITableViewStylePlain];
    self.categrayTable.delegate = self;
    self.categrayTable.dataSource = self;
    self.categrayTable.showsVerticalScrollIndicator = NO;
    self.categrayTable.rowHeight = 90;
    self.categrayTable.separatorInset = UIEdgeInsetsMake( 0, 0, 0, 0);
    [self.rootView addSubview:_categrayTable];

}

#pragma mark - tableView delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSCategoryCell" owner:nil options:nil]lastObject];
    }
    TSCategoryModel *model = self.viewModel.dataArray[indexPath.row];
    [cell configureCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TSCategoryModel *model = self.viewModel.dataArray[indexPath.row];
    TSGoodsRecommandViewModel *viewModel = [[TSGoodsRecommandViewModel alloc] init];
    viewModel.page = 1;
    viewModel.classifyID = model.classifyID;
    viewModel.goodsOrderType = @"1";
    TSGoodsRecommendViewController *goodsRecommedVC = [[TSGoodsRecommendViewController alloc] init];
    goodsRecommedVC.viewModel = viewModel;
    [self.navigationController pushViewController:goodsRecommedVC animated:YES];
}
@end
