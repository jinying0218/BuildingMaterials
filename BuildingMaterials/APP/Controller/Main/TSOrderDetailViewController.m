//
//  TSOrderDetailViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/10.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSOrderDetailViewController.h"
#import "TSOrderDetailViewModel.h"
#import "TSUserModel.h"
#import "TSOrderDetailTableViewCell.h"

static NSString *const OrderDetailTableViewCellIdendifier = @"OrderDetailTableViewCellIdendifier";

@interface TSOrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) TSOrderDetailViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TSOrderDetailViewController
- (instancetype)initWithViewModel:(TSOrderDetailViewModel *)viewModel{
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
    NSDictionary *params = @{@"orderId" : [NSString stringWithFormat:@"%d",self.viewModel.orderId]};
    [TSHttpTool getWithUrl:OrderDetail_URL params:params withCache:NO success:^(id result) {
                NSLog(@"订单详情:%@",result);
      if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *dict in result[@"result"]) {
//                TSWaitOrderModel *orderModel = [[TSWaitOrderModel alloc] init];
//                [orderModel modelWithDict:dict];
//                if ([orderModel.orderStatus isEqualToString:@"WAIT_PAY"]) {
//                    [self.viewModel.dataArray addObject:orderModel];
//                }
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"待付款订单:%@",error);
    }];
/* */
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
    return 90;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailTableViewCellIdendifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSOrderDetailTableViewCell" owner:nil options:nil]lastObject];
    }
//    TSWaitOrderModel *orderModel = self.viewModel.dataArray[indexPath.row];
//    [cell configureCell:orderModel orderDetailButtonHandler:^(TSWaitOrderModel *currentOrderModel) {
        //订单详情
        //        NSLog(@"111111-%@-----%@",orderModel,currentOrderModel);
        
//    } buyNowButtonHandler:^(TSWaitOrderModel *currentOrderModel) {
        //立即购买
        //        NSLog(@"22222--%@-----%@",orderModel,currentOrderModel);
//        TSPayViewController *payVC = [[TSPayViewController alloc] init];
//        payVC.orderId = currentOrderModel.orderId;
//        [self.navigationController pushViewController:payVC animated:YES];
    
//    }];
    return cell;
}

@end
