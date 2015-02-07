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
#import "TSTransportModel.h"
#import "TSOrderSubviewModel.h"
#import "TSOrderTableFooterView.h"

#import <UIImageView+WebCache.h>

#define Tag_orderTable 9000
#define Tag_transportTable 9001

static NSString *const OrderConfirmTableViewCellIdendifier = @"orderConfirmTableViewCellIdendifier";
static NSString *const TransportTableViewCellIdendifier = @"TransportTableViewCellIdendifier";

@interface TSOrderConfirmViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) TSOrderConfirmViewModel *viewModel;
@property (strong, nonatomic) IBOutlet UIView *managerAddressView;
@property (weak, nonatomic) IBOutlet UIButton *managerAddressButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *confirePayButton;
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;
@property (weak, nonatomic) IBOutlet UILabel *postageMoney;
@property (weak, nonatomic) IBOutlet UITableView *transportTable;
@property (weak, nonatomic) IBOutlet UIButton *cancelSelectButton;
@property (strong, nonatomic) IBOutlet UIView *cover;
@property (strong, nonatomic) IBOutlet UIView *popView;
@property (weak, nonatomic) IBOutlet UILabel *popTitle;

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
            for (id companyId in allCompanyIds) {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"CC_ID=%d",[companyId intValue]];
                NSArray *companyArr = [allGoodsArray filteredArrayUsingPredicate:predicate];
                if (companyArr) {
                    TSOrderSubviewModel *subviewModel = [[TSOrderSubviewModel alloc] init];
                    subviewModel.goodsArray = [companyArr mutableCopy];
                    //有多少个分组
                    [self.viewModel.subviewModels addObject:subviewModel];
//                    [self.viewModel.dataArray addObject:companyArr];
                }
            }
            [self.tableView reloadData];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"订单数据加载:%@",error);
    }];
    NSDictionary *paramsTransport = @{@"companyId" : @"3"};
    [TSHttpTool getWithUrl:TransportLoad_URL params:paramsTransport withCache:NO success:^(id result) {
        NSLog(@"TransportLoad_URL---运输方式：%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *dict in result[@"result"]) {
                TSTransportModel *model = [[TSTransportModel alloc] init];
                [model modelWithDict:dict];
                [self.viewModel.transportsArray addObject:model];
            }
            self.cover.hidden = NO;
            self.popView.hidden = NO;
            [self.transportTable reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"TransportLoad_URL---运输方式：%@",error);
    }];
    
}
- (void)configureUI{
    self.tabBarController.tabBar.hidden =  YES;

    [self createNavigationBarTitle:@"订单确认" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];

    self.tableView.tag = Tag_orderTable;
    self.tableView.tableHeaderView = self.managerAddressView;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.cover];
    self.cover.frame = CGRectMake( 0, 0, KscreenW, KscreenH);
    self.cover.hidden = YES;
    
    self.transportTable.delegate = self;
    self.transportTable.dataSource = self;
    self.transportTable.tag = Tag_transportTable;
    self.popView.frame = CGRectMake( (KscreenW - 262)/2 , 200, 262, 134);
    self.popView.hidden = YES;
    self.transportTable.frame = CGRectMake( 0, 24, 262, 80);
    [self.view addSubview:self.popView];
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
    
    [self.cancelSelectButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.cover.hidden = YES;
        self.popView.hidden = YES;
    } forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - dataSource method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == Tag_orderTable) {
        return 94;
    }else {
        return 40;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView.tag == Tag_orderTable) {
        return 35;
    }else {
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView.tag == Tag_orderTable) {
        return 45;
    }else {
        return 0;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView.tag == Tag_orderTable) {
        return self.viewModel.subviewModels.count;
    }else {
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == Tag_orderTable) {
        TSOrderSubviewModel *subviewModel = self.viewModel.subviewModels[section];
        return subviewModel.goodsArray.count;
//        [self.viewModel.dataArray[section] count];
    }else {
        return self.viewModel.transportsArray.count;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView.tag == Tag_orderTable) {
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"orderTableHeaderViewIdentifer"];
        if (!headerView) {
            headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"orderTableHeaderViewIdentifer"];
            headerView.contentView.backgroundColor = [UIColor clearColor];
        }
//        TSOrderModel *model = self.viewModel.dataArray[section][0];
        TSOrderSubviewModel *subviewModel = self.viewModel.subviewModels[section];
        TSOrderModel *model = subviewModel.goodsArray[0];

        for (UIView *subview in headerView.contentView.subviews) {
            [subview removeFromSuperview];
        }
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake( 0, 10, KscreenW, 25)];
        view.backgroundColor = [UIColor whiteColor];
        [headerView.contentView addSubview:view];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake( 10, 0, KscreenW, 25)];
        label.text = model.companyName;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:15];
        [view addSubview:label];
        return headerView;
    }else {
        return nil;
    }
}

//   这个地方的section很有意思，有待研究一下  cao!
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (tableView.tag == Tag_orderTable) {
        TSOrderTableFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"orderTableFooterViewIdentifer"];
        if (!footerView) {
            footerView = [[TSOrderTableFooterView alloc] initWithReuseIdentifier:@"orderTableFooterViewIdentifer"];
            footerView.contentView.backgroundColor = [UIColor clearColor];
            footerView.backView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, KscreenW, 25)];
            footerView.backView.backgroundColor = [UIColor whiteColor];
            [footerView.contentView addSubview:footerView.backView];
            footerView.transportName = [[UILabel alloc] initWithFrame:CGRectMake( 10, 0, KscreenW, 25)];
            footerView.transportName.textColor = [UIColor blackColor];
            footerView.transportName.font = [UIFont systemFontOfSize:14];
            [footerView.backView addSubview:footerView.transportName];
        }
        footerView.indexSection = section;
        TSOrderSubviewModel *subviewModel = self.viewModel.subviewModels[section];
        if (subviewModel.transportModel) {
            footerView.transportName.text = subviewModel.transportModel.transportName;
        }else {
            footerView.transportName.text = @"选择运输方式";
        }
        
        @weakify(self);
        [footerView bk_whenTapped:^{
            @strongify(self);
            [self showProgressHUD];
            self.viewModel.currentSection = footerView.indexSection;
            NSDictionary *paramsTransport = @{@"companyId" : @"3"};
            [TSHttpTool getWithUrl:TransportLoad_URL params:paramsTransport withCache:NO success:^(id result) {
                [self hideProgressHUD];
                if ([result[@"success"] intValue] == 1) {
                    [self.viewModel.transportsArray removeAllObjects];
                    for (NSDictionary *dict in result[@"result"]) {
                        TSTransportModel *model = [[TSTransportModel alloc] init];
                        [model modelWithDict:dict];
                        [self.viewModel.transportsArray addObject:model];
                    }
                    self.cover.hidden = NO;
                    self.popView.hidden = NO;
                    [self.transportTable reloadData];
                }
            } failure:^(NSError *error) {
                [self hideProgressHUD];
                [self showProgressHUD:error.domain delay:1];
            }];
        }];
        
        return footerView;
    }else {
        return nil;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == Tag_orderTable) {
        TSOrderConfirmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderConfirmTableViewCellIdendifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TSOrderConfirmTableViewCell" owner:nil options:nil]lastObject];
        }
        TSOrderSubviewModel *subviewModel = self.viewModel.subviewModels[indexPath.section];
        TSOrderModel *model = subviewModel.goodsArray[indexPath.row];
        cell.goodsName.text = model.goodsName;
        cell.goodsParamters.text = model.goodsParameters;
        cell.goodsNumberPrice.text = [NSString stringWithFormat:@"%d * %d",model.price,model.goodsNumber];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:model.goodsHeadImageURL] placeholderImage:[UIImage imageNamed:@"not_load"]];
        return cell;
    }else {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:TransportTableViewCellIdendifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TransportTableViewCellIdendifier];
        }
        TSTransportModel *model = self.viewModel.transportsArray[indexPath.row];
        cell.textLabel.text = model.transportName;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == Tag_transportTable) {
        //选择运送方式
        TSTransportModel *transportModel = self.viewModel.transportsArray[indexPath.row];
        TSOrderSubviewModel *subviewModel = self.viewModel.subviewModels[self.viewModel.currentSection];
        subviewModel.transportModel = transportModel;
        
        TSOrderTableFooterView *footerView = (TSOrderTableFooterView *)[self.tableView footerViewForSection:self.viewModel.currentSection];
        footerView.transportName.text = transportModel.transportName;
        
        self.cover.hidden = YES;
        self.popView.hidden = YES;
    }
}

@end
