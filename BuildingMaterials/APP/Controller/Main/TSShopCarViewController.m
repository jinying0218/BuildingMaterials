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
#import "NSArray+BSJSONAdditions.h"
#import "NSDictionary+BSJSONAdditions.h"
#import "JSONKit.h"

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

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self initializeData];
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
        NSLog(@"GoodsCarLoad_URL购物车:%@",result);
        if ([result[@"success"] intValue] == 1) {
            [self.viewModel.subviewModels removeAllObjects];
            for (NSDictionary *dict in result[@"result"]) {
                TSShopCarModel *model = [[TSShopCarModel alloc] init];
                [model setValueWithDict:dict];
                TSShopCarCellSubviewModel *subviewModel = [[TSShopCarCellSubviewModel alloc] init];
                subviewModel.shopCarMoney = self.viewModel.shopCarMoney;
                subviewModel.inShopCar = self.viewModel.allInShopCar;
                subviewModel.goodsCount = model.goods_number;
                subviewModel.shopCarModel = model;
                subviewModel.goodsTotalMoney = subviewModel.goodsCount * model.goods_price;

                [self.viewModel.subviewModels addObject:subviewModel];
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

//计算总价格
- (void)layoutSubviews{
    float goodsTotalMoney = 0;
    int goodsCount = 0;
    int index = 0;
    for (TSShopCarCellSubviewModel *oneSubviewModel in self.viewModel.subviewModels) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        TSShopCarTableViewCell *cell = (TSShopCarTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];

        if (oneSubviewModel.inShopCar) {
            goodsTotalMoney += oneSubviewModel.goodsTotalMoney;
            cell.selectButton.selected = YES;
            goodsCount ++;
        }else {
            cell.selectButton.selected = NO;
        }
        index ++;
    }
    if (goodsCount == self.viewModel.subviewModels.count) {
        self.selectAllButton.selected = YES;
    }else {
        self.selectAllButton.selected = NO;
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
             self.totalMoney.text = [NSString stringWithFormat:@"￥%.2f",[change[NSKeyValueChangeNewKey] floatValue]];
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
        if (self.selectAllButton.selected) {
            for (TSShopCarCellSubviewModel *oneSubviewModel in self.viewModel.subviewModels) {
                oneSubviewModel.inShopCar = YES;
            }
        }else {
            for (TSShopCarCellSubviewModel *oneSubviewModel in self.viewModel.subviewModels) {
                oneSubviewModel.inShopCar = NO;
            }
        }
        [self layoutSubviews];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.payButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        int shopCarGoodsNumber = 0;
        for (TSShopCarCellSubviewModel *subviewModel in self.viewModel.subviewModels) {
            if (subviewModel.inShopCar) {
                shopCarGoodsNumber ++;
            }
        }
        if (shopCarGoodsNumber == 0) {
            [self showProgressHUD:@"请添加要购买的商品" delay:1];
            return ;
        }
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
        for (TSShopCarCellSubviewModel *subviewModel in self.viewModel.subviewModels) {
            if (subviewModel.inShopCar) {
                
                NSData *data = [subviewModel.shopCarModel.parameters JSONData];
                NSString *goodsParameters = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                NSDictionary *dict = @{@"carId" : [NSString stringWithFormat:@"%d",subviewModel.shopCarModel.C_ID],
                                       @"seckillId" : @"",
                                       @"goodsId" : [NSString stringWithFormat:@"%d",subviewModel.shopCarModel.goods_id],
                                       @"price" : [NSString stringWithFormat:@"%d",subviewModel.shopCarModel.goods_price],
                                       @"number" : [NSString stringWithFormat:@"%d",subviewModel.shopCarModel.goods_number],
                                       @"goodsParameters" : goodsParameters};
                [arr addObject:dict];
            }
        }
        
        NSDictionary *goodsInformation = @{@"post" : arr};
        NSDictionary *params = @{@"userId" : [NSString stringWithFormat:@"%d",self.userModel.userId],
                                 @"goodsInformation" : [goodsInformation JSONString]};
        [TSHttpTool postWithUrl:OrderSure_URL params:params success:^(id result) {
            NSLog(@"OrderSure_URL--结算：%@",result);
            if ([result[@"success"] intValue] == 1) {
                TSOrderConfirmViewModel *viewModel = [[TSOrderConfirmViewModel alloc] init];
                TSOrderConfirmViewController *orderConfirmVC = [[TSOrderConfirmViewController alloc] initWithViewModel:viewModel];
                [self.navigationController pushViewController:orderConfirmVC animated:YES];
            }
        } failure:^(NSError *error) {
            NSLog(@"OrderSure_URL--结算：%@",error);
        }];
    } forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - dataSource method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
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
        cell.goodsParameters.adjustsFontSizeToFitWidth = YES;
        cell.goodsParameters.numberOfLines = 0;
    }
    
    TSShopCarCellSubviewModel *subviewModel = self.viewModel.subviewModels[indexPath.row];
    [cell attachViewModel:subviewModel  carInfo:^(BOOL refreshCarMoney) {
        [self layoutSubviews];
    }];
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
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0){
    return @"删除";
}

@end
