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
//#import "NSArray+BSJSONAdditions.h"
//#import "NSDictionary+BSJSONAdditions.h"
#import "JSONKit.h"
#import "TSPayViewController.h"

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
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

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
                if (!orderModel.goodsParameters) {
                    orderModel.goodsParameters = @"";
                }else {
                    if ([orderModel.goodsParameters hasPrefix:@"\""]) {
                        NSMutableString *goodsParameters = [orderModel.goodsParameters mutableCopy];
                        [goodsParameters deleteCharactersInRange:NSMakeRange( goodsParameters.length - 1, 1)];
                        [goodsParameters deleteCharactersInRange:NSMakeRange( 0, 1)];
                        orderModel.goodsParameters = goodsParameters;
                    }
                }
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
                    for (TSOrderModel *orderModel in subviewModel.goodsArray) {
                        subviewModel.companyTotalPrice += (float)orderModel.goodsNumber * orderModel.price;
                        NSLog(@"%f",subviewModel.companyTotalPrice);
                    }

                }
            }
            [self.tableView reloadData];
            [self countTotalMoney];
/*
            //默认提示第一个选择运送方式
            TSOrderModel *firstOrderModel = [self.viewModel.subviewModels[0] goodsArray][0];
            NSDictionary *paramsTransport = @{@"companyId" : [NSString stringWithFormat:@"%d",firstOrderModel.CC_ID]};
            [TSHttpTool getWithUrl:TransportLoad_URL params:paramsTransport withCache:NO success:^(id result) {
                //        NSLog(@"TransportLoad_URL---运输方式：%@",result);
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
*/
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
    
    self.addressLabel.adjustsFontSizeToFitWidth = YES;

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
    self.popView.bounds = CGRectMake( 0, 0, 262, 134);
    self.popView.center = self.view.center;
    self.popView.hidden = YES;
    self.transportTable.frame = CGRectMake( 0, 24, 262, 80);
    [self.view addSubview:self.popView];
}

#pragma mark - blind Methods
- (void)blindViewModel{
    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,address)
     options:NSKeyValueObservingOptionNew
     block:^(TSOrderConfirmViewController *observer, TSOrderConfirmViewModel *object, NSDictionary *change) {
         if (![[change objectForKey:NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             observer.addressLabel.text = change[NSKeyValueChangeNewKey];
         }
     }];

}

- (void)blindActionHandler{
    @weakify(self);
    [self.confirePayButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        
        NSMutableArray *post = [[NSMutableArray alloc] initWithCapacity:0];
        for (TSOrderSubviewModel *subviewModel in self.viewModel.subviewModels) {
            NSMutableArray *goods = [[NSMutableArray alloc] initWithCapacity:0];
            for (TSOrderModel *orderModel in subviewModel.goodsArray) {
                NSDictionary *dict = @{@"goodsId" : [NSString stringWithFormat:@"%d",orderModel.G_ID],
                                       @"price" : [NSString stringWithFormat:@"%.2f",orderModel.price],
                                       @"number" : [NSString stringWithFormat:@"%d",orderModel.goodsNumber],
                                       @"goodsParameters" : orderModel.goodsParameters};
                [goods addObject:dict];
            }
            TSOrderModel *firstOrderModel = [subviewModel goodsArray][0];
            if (!subviewModel.transportModel) {
                [self showProgressHUD:@"请选择配送方式" delay:1];
                return ;
            }
            if (!self.viewModel.address ||
                [self.viewModel.address isEqualToString:@""]) {
                [self showProgressHUD:@"请选择地址" delay:1];
                return ;
            }
            
            NSDictionary *dict = @{@"companyId" : [NSString stringWithFormat:@"%d",firstOrderModel.CC_ID],
                                   @"totalPrice" : [NSString stringWithFormat:@"%.2f",subviewModel.companyTotalPrice],
                                   @"goodsPrice" : [NSString stringWithFormat:@"%.2f",firstOrderModel.price],
                                   @"transportPrice" : [NSString stringWithFormat:@"%.2f",subviewModel.transportPrice],
                                   @"transportName" : subviewModel.transportModel.transportName,
                                   @"transportType" : [NSString stringWithFormat:@"%d",subviewModel.transportModel.transportType],
                                   @"goods" : goods};
            [post addObject:dict];
        }
        NSDictionary *companyPostDict = @{@"post" : post};
        
        TSOrderModel *firstOrderModel = [[self.viewModel.subviewModels[0] goodsArray] objectAtIndex:0];

        NSDictionary *orderPostDict = @{@"userId" : [NSString stringWithFormat:@"%d",self.userModel.userId],
                                        @"seckillId" : [NSString stringWithFormat:@"%d",firstOrderModel.seckillId],
                                        @"goodsFee" : @"0",
                                        @"transportFee" : @"0",
                                 
                                        @"totalFee" : @"0",
                                        @"address" : self.viewModel.address};

        
        NSDictionary *params = @{@"orderPost" : [orderPostDict JSONString],
                                 @"companyPost" : [companyPostDict JSONString]};
        
        NSLog(@"\n orderPost:%@",orderPostDict);
        NSLog(@"\n companyPost:%@",companyPostDict);

//        NSLog(@"%@",params);
        [self showProgressHUD];
        [TSHttpTool postWithUrl:OrderPost_URL params:params success:^(id result) {
            [self hideProgressHUD];
            NSLog(@"OrderPost_URL------确定支付:%@",result);
            if ([result[@"success"] intValue] == 1) {
                NSString *orderCode = result[@"result"];
                TSPayViewController *payVC = [[TSPayViewController alloc] init];
                payVC.orderCode = orderCode;
                [self.navigationController pushViewController:payVC animated:YES];
            }
        } failure:^(NSError *error) {
            [self hideProgressHUD];
            NSLog(@"OrderPost_URL------确定支付:%@",error);
        }];
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.managerAddressButton bk_addEventHandler:^(id sender) {
      @strongify(self);
        TSAddressViewModel *viewModel = [[TSAddressViewModel alloc] init];
        viewModel.allowSelect = YES;
        TSAddressViewController *addressVC = [[TSAddressViewController alloc] initWithViewModel:viewModel address:^(NSString *address) {
            @strongify(self);
            self.viewModel.address = address;
        }];
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
            TSOrderModel *firstOrderModel = [self.viewModel.subviewModels[footerView.indexSection] goodsArray][0];
            NSDictionary *paramsTransport = @{@"companyId" : [NSString stringWithFormat:@"%d",firstOrderModel.CC_ID]};
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

#pragma mark - 定制某一行Cell
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
        cell.goodsNumberPrice.text = [NSString stringWithFormat:@"￥%.2f * %d",model.price,model.goodsNumber];
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
#pragma mark - 选择某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == Tag_transportTable) {
        //选择运送方式
        TSTransportModel *transportModel = self.viewModel.transportsArray[indexPath.row];
        TSOrderSubviewModel *subviewModel = self.viewModel.subviewModels[self.viewModel.currentSection];
        subviewModel.transportModel = transportModel;
        subviewModel.companyTotalPrice = 0;
        for (TSOrderModel *orderModel in subviewModel.goodsArray) {
            subviewModel.companyTotalPrice += orderModel.goodsNumber * orderModel.price;
            subviewModel.goodsWeight += orderModel.goodsWeight;
        }
        switch (transportModel.transportType) {
            case 1:{
                subviewModel.transportPrice = 0;
            }
                break;
            case 2:{
                if (subviewModel.goodsWeight > transportModel.transportFirstWeight) {
                    subviewModel.transportPrice =  (subviewModel.goodsWeight - transportModel.transportFirstWeight) * transportModel.transportOverFee + transportModel.transportFirstFee;
                }else {
                    subviewModel.transportPrice = transportModel.transportFirstFee;
                }
            }
                break;
            case 3:{
                subviewModel.transportPrice = transportModel.transportFee;

            }
                break;
            case 4:{
                subviewModel.transportPrice = transportModel.transportFee;

            }
                break;
            default:
                break;
        }
        
        [self countTotalMoney];
        
        TSOrderTableFooterView *footerView = (TSOrderTableFooterView *)[self.tableView footerViewForSection:self.viewModel.currentSection];
        footerView.transportName.text = transportModel.transportName;
        
        self.cover.hidden = YES;
        self.popView.hidden = YES;
    }
}
#pragma mark - 计算总价格
- (void)countTotalMoney{
    self.viewModel.totalGoodsMoney = 0;
    self.viewModel.totalTransportMoney = 0;
    for (TSOrderSubviewModel *subviewModel in self.viewModel.subviewModels) {
        self.viewModel.totalGoodsMoney += subviewModel.companyTotalPrice;
        self.viewModel.totalTransportMoney += subviewModel.transportPrice;
    }
    
    self.postageMoney.text = [NSString stringWithFormat:@"运费：￥%.2f",self.viewModel.totalTransportMoney];
    self.totalMoney.text = [NSString stringWithFormat:@"总价：￥%.2f",self.viewModel.totalGoodsMoney + self.viewModel.totalTransportMoney];
}
@end
