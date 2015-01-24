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
//            [self.viewModel.addressArray removeAllObjects];
//            for (NSDictionary *dict in result[@"result"]) {
//                TSAddressModel *model = [[TSAddressModel alloc] init];
//                [model setValueWithDict:dict];
//                [self.viewModel.addressArray addObject:model];
//            }
//            [self.tableView reloadData];
            
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
- (void)blindViewModel{
}

- (void)blindActionHandler{
}

#pragma mark - dataSource method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSShopCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ShopCarTableViewCellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSShopCarTableViewCell" owner:nil options:nil]lastObject];
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = [UIColor colorWithHexString:@"1ca6df"];
        cell.selectedBackgroundView = backView;
    }
    
    TSShopCarModel *model = self.viewModel.dataArray[indexPath.row];
    
    return cell;
}
#pragma mark - tableview  delegate
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        TSAddressModel *model = self.viewModel.addressArray[indexPath.row];
        NSDictionary *params = @{@"addressId" : @"",
                                 @"userId" : [NSString stringWithFormat:@"%d",self.userModel.userId]};
        [TSHttpTool getWithUrl:AddressDelete_URL params:params withCache:NO success:^(id result) {
            if ([result[@"success"] intValue] == 1) {
                NSLog(@"删除地址：%@",result);
                [UIView animateWithDuration:0.25 animations:^{
                } completion:^(BOOL finished) {
                    if (finished) {
                        [self.viewModel.dataArray removeObjectAtIndex:indexPath.row];
                        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                    }
                }];
            }
        } failure:^(NSError *error) {
            
        } ];
    }
}

@end
