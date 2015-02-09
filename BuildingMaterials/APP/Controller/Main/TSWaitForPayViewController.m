//
//  TSWaitForPayViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/7.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSWaitForPayViewController.h"
#import "TSWaitForPayViewModel.h"
#import "TSWaitForPayTableViewCell.h"
#import "TSUserModel.h"
#import "TSWaitOrderModel.h"
#import "TSPayViewController.h"

#import "TSOrderDetailViewController.h"
#import "TSOrderDetailViewModel.h"

static NSString *const WaitForPayTableViewCellIdendifier = @"WaitForPayTableViewCellIdendifier";


@interface TSWaitForPayViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) TSWaitForPayViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TSWaitForPayViewController

- (instancetype)initWithViewModel:(TSWaitForPayViewModel *)viewModel{
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
    TSUserModel *userModel = [TSUserModel getCurrentLoginUser];
    NSDictionary *params = @{@"userId" : [NSString stringWithFormat:@"%d",userModel.userId]};
    [TSHttpTool getWithUrl:WaitForPay_URL params:params withCache:NO success:^(id result) {
//        NSLog(@"待付款订单:%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *dict in result[@"result"]) {
                TSWaitOrderModel *orderModel = [[TSWaitOrderModel alloc] init];
                [orderModel modelWithDict:dict];
                if ([orderModel.orderStatus isEqualToString:@"WAIT_PAY"]) {
                    [self.viewModel.dataArray addObject:orderModel];
                }
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"待付款订单:%@",error);
    }];
    
}
- (void)configureUI{
    self.tabBarController.tabBar.hidden =  YES;
    
    [self createNavigationBarTitle:@"待付订单" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

}

- (void)blindViewModel{
    
}
- (void)blindActionHandler{
}

#pragma mark - dataSource method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSWaitForPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WaitForPayTableViewCellIdendifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSWaitForPayTableViewCell" owner:nil options:nil]lastObject];
    }
    TSWaitOrderModel *orderModel = self.viewModel.dataArray[indexPath.row];
    [cell configureCell:orderModel orderDetailButtonHandler:^(TSWaitOrderModel *currentOrderModel) {
        //订单详情
//        NSLog(@"111111-%@-----%@",orderModel,currentOrderModel);
        TSOrderDetailViewModel *viewModel = [[TSOrderDetailViewModel alloc] init];
        viewModel.orderId = currentOrderModel.orderId;
        TSOrderDetailViewController *orderDetailVC = [[TSOrderDetailViewController alloc] initWithViewModel:viewModel];
        [self.navigationController pushViewController:orderDetailVC animated:YES];
    } buyNowButtonHandler:^(TSWaitOrderModel *currentOrderModel) {
        //立即购买
//        NSLog(@"22222--%@-----%@",orderModel,currentOrderModel);
        TSPayViewController *payVC = [[TSPayViewController alloc] init];
        payVC.orderId = currentOrderModel.orderId;
        [self.navigationController pushViewController:payVC animated:YES];

    }];
    return cell;
}

@end
