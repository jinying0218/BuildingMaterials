//
//  TSHavePayedViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/7.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSHavePayedViewController.h"
#import "TSHavePayedViewModel.h"
#import "TSHavePayedTableViewCell.h"
#import "TSWaitOrderModel.h"
#import "TSUserModel.h"

static NSString *const HavePayedTableViewCellIdendifier = @"HavePayedTableViewCellIdendifier";

@interface TSHavePayedViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) TSHavePayedViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TSHavePayedViewController
- (instancetype)initWithViewModel:(TSHavePayedViewModel *)viewModel{
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
                if ([orderModel.orderStatus isEqualToString:@"TIME_OVER"]) {
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
    
    [self createNavigationBarTitle:@"已付订单" leftButtonImageName:@"Previous" rightButtonImageName:nil];
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
    return 128;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.viewModel.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSHavePayedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HavePayedTableViewCellIdendifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSHavePayedTableViewCell" owner:nil options:nil]lastObject];
    }
    TSWaitOrderModel *orderModel = self.viewModel.dataArray[indexPath.row];
    @weakify(self);
    [cell configureCell:orderModel orderDetailButtonHandler:^(NSIndexPath *indexPath) {
        //订单详情
        @strongify(self);
        
    } moneyBackButtonHandler:^(NSIndexPath *indexPath) {
        //申请退款
        @strongify(self);
        
    } checkTransportButtonHandler:^(NSIndexPath *indexPath) {
        //查看物流
        @strongify(self);
        
    } confirmReceiveButtonHandler:^(NSIndexPath *indexPath) {
        //确认收货
        @strongify(self);
        
    }];
    return cell;
}

@end
