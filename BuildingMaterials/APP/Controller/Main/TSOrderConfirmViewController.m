//
//  TSOrderViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/31.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSOrderConfirmViewController.h"
#import "TSOrderConfirmViewModel.h"
#import "TSOrderConfirmTableViewCell.h"
#import "TSAddressViewController.h"
#import "TSAddressViewModel.h"
#import "TSUserModel.h"
#import "TSOrderModel.h"

#import <UIImageView+WebCache.h>

static NSString *const OrderConfirmTableViewCellIdendifier = @"orderConfirmTableViewCellIdendifier";

@interface TSOrderConfirmViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) TSOrderConfirmViewModel *viewModel;
@property (strong, nonatomic) IBOutlet UIView *managerAddressView;
@property (weak, nonatomic) IBOutlet UIButton *managerAddressButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *confirePayButton;
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;
@property (weak, nonatomic) IBOutlet UILabel *postageMoney;
@property (nonatomic, strong) TSUserModel *userModel;

@end

@implementation TSOrderConfirmViewController
- (instancetype)initWithViewModel:(TSOrderConfirmViewModel *)viewModel{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeData];
    [self configureUI];
    [self blindViewModel];
    [self blindActionHandler];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeData{
    self.userModel = [TSUserModel getCurrentLoginUser];
    NSDictionary *params = @{@"userId" : @(self.userModel.userId)};
    [TSHttpTool getWithUrl:OrderSureLoad_URL params:params withCache:NO success:^(id result) {
        NSLog(@"订单数据加载:%@",result);
        if ([result[@"success"] intValue] == 1) {
            NSMutableArray *allGoodsArray = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray *allCompanyIds = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dict in result[@"result"]) {
                TSOrderModel *orderModel = [[TSOrderModel alloc] init];
                [orderModel modelWithDict:dict];
                [allGoodsArray addObject:orderModel];
                if (![allCompanyIds containsObject:@(orderModel.CC_ID)]) {
                    [allCompanyIds addObject:@(orderModel.CC_ID)];
                }
            }
//            [self.viewModel.dataArray addObject:allGoodsArray];
            for (id companyId in allCompanyIds) {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"CC_ID=%d",[companyId intValue]];
                NSArray *companyArr = [allGoodsArray filteredArrayUsingPredicate:predicate];
                [self.viewModel.dataArray addObject:companyArr];
            }
            [self.tableView reloadData];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"订单数据加载:%@",error);
    }];
}
- (void)configureUI{
    self.tabBarController.tabBar.hidden =  YES;

    [self createNavigationBarTitle:@"订单确认" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    self.tableView.tableHeaderView = self.managerAddressView;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)blindViewModel{
    
}

- (void)blindActionHandler{
    @weakify(self);
    [self.confirePayButton bk_addEventHandler:^(id sender) {
//        @strongify(self);
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.managerAddressButton bk_addEventHandler:^(id sender) {
      @strongify(self);
        TSAddressViewModel *viewModel = [[TSAddressViewModel alloc] init];
        TSAddressViewController *addressVC = [[TSAddressViewController alloc] initWithViewModel:viewModel];
        [self.navigationController pushViewController:addressVC animated:YES];

    } forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - dataSource method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 45;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel.dataArray[section] count];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"orderTableHeaderViewIdentifer"];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"orderTableHeaderViewIdentifer"];
        headerView.contentView.backgroundColor = [UIColor lightGrayColor];
    }
    TSOrderModel *model = self.viewModel.dataArray[section][0];
    headerView.textLabel.text = model.companyName;
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"orderTableFooterViewIdentifer"];
    if (!footerView) {
        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"orderTableFooterViewIdentifer"];
        footerView.contentView.backgroundColor = [UIColor lightGrayColor];
        UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake( 15, 0, KscreenW - 30, 30)];
        testLabel.text = @"快递名称";
        testLabel.font = [UIFont systemFontOfSize:13];

        [footerView.contentView addSubview:testLabel];
    }
    
//    footerView.textLabel.text = @"快递名称";
    return footerView;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSOrderConfirmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderConfirmTableViewCellIdendifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSOrderConfirmTableViewCell" owner:nil options:nil]lastObject];
    }
    
    TSOrderModel *model = self.viewModel.dataArray[indexPath.section][indexPath.row];
    cell.goodsName.text = model.goodsName;
    cell.goodsParamters.text = model.goodsParameters;
    cell.goodsNumberPrice.text = [NSString stringWithFormat:@"%d * %d",model.price,model.goodsNumber];
    [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:model.goodsHeadImageURL] placeholderImage:[UIImage imageNamed:@"not_load"]];
    return cell;
}



@end
