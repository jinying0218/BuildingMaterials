//
//  TSShopCarViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/24.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSShopCarViewController.h"
#import "TSShopCarViewModel.h"
#import "TSUserModel.h"
#import "TSShopCarModel.h"
#import "TSShopCarTableViewCell.h"
#import "TSShopCarCellSubviewModel.h"
#import "TSOrderConfirmViewController.h"
#import "TSOrderConfirmViewModel.h"

static NSString *const ShopCarTableViewCellIdentifier = @"ShopCarTableViewCellIdentifier";

@interface TSShopCarViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) TSShopCarViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;
@property (weak, nonatomic) IBOutlet UIButton *selectAllButton;
@property (nonatomic, strong) TSUserModel *userModel;

@end

@implementation TSShopCarViewController
- (instancetype)initWithViewModel:(TSShopCarViewModel *)viewModel{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden =  YES;
    self.userModel = [TSUserModel getCurrentLoginUser];
    [self initializeData];
    [self setupUI];
    [self blindViewModel];
    [self blindActionHandler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeData{
    NSDictionary *params = @{@"userId" : [NSString stringWithFormat:@"%d",self.userModel.userId]};
    [TSHttpTool getWithUrl:GoodsCarLoad_URL params:params withCache:NO success:^(id result) {
        NSLog(@"购物车:%@",result);
        if ([result[@"success"] intValue] == 1) {
            [self.viewModel.subviewModels removeAllObjects];
            for (NSDictionary *dict in result[@"result"]) {
                TSShopCarModel *model = [[TSShopCarModel alloc] init];
                [model setValueWithDict:dict];
                TSShopCarCellSubviewModel *subviewModel = [[TSShopCarCellSubviewModel alloc] init];
                subviewModel.inShopCar = self.viewModel.allInShopCar;
                subviewModel.shopCarMoney = self.viewModel.shopCarMoney;
                subviewModel.goodsCount = model.goods_number;
                subviewModel.shopCarModel = model;
                subviewModel.goodsTotalMoney = subviewModel.goodsCount * model.goods_price;
                [self.viewModel.subviewModels addObject:subviewModel];
//                [self.viewModel.dataArray addObject:model];
            }
            [self.tableView reloadData];
            [self layoutSubviews];
        }
    } failure:^(NSError *error) {
        NSLog(@"购物车:%@",error);
    }];
}
#pragma mark - set up UI
- (void)setupUI{
    [self createNavigationBarTitle:@"购物车" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)layoutSubviews{
    float goodsTotalMoney = 0;
    for (TSShopCarCellSubviewModel *oneSubviewModel in self.viewModel.subviewModels) {
        if (oneSubviewModel.inShopCar) {
            goodsTotalMoney += oneSubviewModel.goodsTotalMoney;
        }
    }
    [self.viewModel.shopCarMoney setMoney:goodsTotalMoney];
}
- (void)blindViewModel{
    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,shopCarGoodsMoney)
     options:NSKeyValueObservingOptionNew
     block:^(TSShopCarViewController *observer, TSShopCarViewModel *object, NSDictionary *change) {
         if (![change[NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             self.totalMoney.text = [NSString stringWithFormat:@"%.2f",[change[NSKeyValueChangeNewKey] floatValue]];
         }
    }];
    [self.KVOController
     observe:self.viewModel
     keyPath:@keypath(self.viewModel,allInShopCar)
     options:NSKeyValueObservingOptionNew
     block:^(TSShopCarViewController *observer, TSShopCarViewModel *object, NSDictionary *change) {
         if (![change[NSKeyValueChangeNewKey] isEqual:[NSNull null]]) {
             [self layoutSubviews];
         }
     }];


}

- (void)blindActionHandler{
    @weakify(self);
    [self.selectAllButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.selectAllButton.selected = !self.selectAllButton.selected;
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.payButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        TSOrderConfirmViewModel *viewModel = [[TSOrderConfirmViewModel alloc] init];
        TSOrderConfirmViewController *orderConfirmVC = [[TSOrderConfirmViewController alloc] initWithViewModel:viewModel];
        [self.navigationController pushViewController:orderConfirmVC animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - dataSource method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.subviewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSShopCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ShopCarTableViewCellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSShopCarTableViewCell" owner:nil options:nil]lastObject];
//        UIView *backView = [[UIView alloc] init];
//        backView.backgroundColor = [UIColor colorWithHexString:@"1ca6df"];
//        cell.selectedBackgroundView = backView;
        cell.goodsCount.layer.borderColor = [UIColor colorWithHexString:@"f4f4f4"].CGColor;
        cell.goodsCount.layer.borderWidth = 1;
        cell.minutsButton.layer.borderColor = [UIColor colorWithHexString:@"f4f4f4"].CGColor;
        cell.minutsButton.layer.borderWidth = 1;
        cell.plusButton.layer.borderColor = [UIColor colorWithHexString:@"f4f4f4"].CGColor;
        cell.plusButton.layer.borderWidth = 1;
    }
    
//    TSShopCarModel *model = self.viewModel.dataArray[indexPath.row];
    TSShopCarCellSubviewModel *subviewModel = self.viewModel.subviewModels[indexPath.row];
    [cell attachViewModel:subviewModel];
    return cell;
}
#pragma mark - tableview  delegate
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        TSShopCarCellSubviewModel *subviewModel = self.viewModel.subviewModels[indexPath.row];
        
        NSDictionary *params = @{@"id" : [NSString stringWithFormat:@"%d",subviewModel.shopCarModel.C_ID]};
        [TSHttpTool getWithUrl:GoodsCarDeleteURL params:params withCache:NO success:^(id result) {
            if ([result[@"success"] intValue] == 1) {
//                NSLog(@"删购物车商品：%@",result);
                [UIView animateWithDuration:0.25 animations:^{
                } completion:^(BOOL finished) {
                    if (finished) {
                        [self.viewModel.subviewModels removeObjectAtIndex:indexPath.row];
                        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                    }
                }];
            }
        } failure:^(NSError *error) {
            
        } ];
    }
}

@end