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
    
    [self configureUI];
    [self blindViewModel];
    [self blindActionHandler];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configureUI{
    self.tabBarController.tabBar.hidden =  YES;

    [self createNavigationBarTitle:@"订单确认" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    self.tableView.tableHeaderView = self.managerAddressView;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.viewModel.dataArray setArray:@[@[@"",@"",@""],@[@"",@"",@""],@[@"",@"",@""]]];
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
    headerView.textLabel.text = @"店铺名称";
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
        //        UIView *backView = [[UIView alloc] init];
        //        backView.backgroundColor = [UIColor colorWithHexString:@"1ca6df"];
        //        cell.selectedBackgroundView = backView;
//        cell.goodsCount.layer.borderColor = [UIColor colorWithHexString:@"f4f4f4"].CGColor;
//        cell.goodsCount.layer.borderWidth = 1;
//        cell.minutsButton.layer.borderColor = [UIColor colorWithHexString:@"f4f4f4"].CGColor;
//        cell.minutsButton.layer.borderWidth = 1;
//        cell.plusButton.layer.borderColor = [UIColor colorWithHexString:@"f4f4f4"].CGColor;
//        cell.plusButton.layer.borderWidth = 1;
    }
    
    //    TSShopCarModel *model = self.viewModel.dataArray[indexPath.row];
//    TSShopCarCellSubviewModel *subviewModel = self.viewModel.subviewModels[indexPath.row];
//    [cell attachViewModel:subviewModel];
    [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"not_load"]];
    cell.goodsName.text = @"test";
    return cell;
}



@end
