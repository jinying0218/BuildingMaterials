//
//  TSCollectViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/1/24.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSCollectViewController.h"
#import "TSCollectViewModel.h"
#import "TSUserModel.h"
#import "TSCollectGoodsModel.h"
#import "TSCollectionShopModel.h"

#import "TSGoodsCollectTableViewCell.h"
#import "TSShopCollectTableViewCell.h"

static NSString *const GoodsCollectTableViewCellIdentifier = @"GoodsCollectTableViewCellIdentifier";
static NSString *const ShopCollectTableViewCellIdentifier = @"ShopCollectTableViewCellIdentifier";

@interface TSCollectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) TSCollectViewModel *viewModel;
@property (nonatomic, strong) TSUserModel *userModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *goodsCollectButton;
@property (weak, nonatomic) IBOutlet UIButton *shopCollectButton;
@property (weak, nonatomic) IBOutlet UILabel *selectLine;

@end

@implementation TSCollectViewController
- (instancetype)initWithViewModel:(TSCollectViewModel *)viewModel{
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
    [TSHttpTool getWithUrl:CollectLoad_URL params:params withCache:NO success:^(id result) {
        NSLog(@"收藏列表:%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *dict in result[@"goods2"]) {
                TSCollectGoodsModel *model = [[TSCollectGoodsModel alloc]init];
                [model setValueWithDict:dict];
                [self.viewModel.goodsDataArray addObject:model];
            }
            for (NSDictionary *dict in result[@"company"]) {
                TSCollectionShopModel *model = [[TSCollectionShopModel alloc] init];
                [model setValueWithDict:dict];
                [self.viewModel.shopDataArray addObject:model];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"收藏列表:%@",error);
    }];
}
#pragma mark - set up UI
- (void)setupUI{
    [self createNavigationBarTitle:@"我的收藏" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    self.goodsCollectButton.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}
- (void)blindViewModel{
}

- (void)blindActionHandler{
    @weakify(self);
    [self.goodsCollectButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.selectLine.frame = CGRectMake( 0, 28, KscreenW/2, 2);
        self.goodsCollectButton.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        self.shopCollectButton.backgroundColor = [UIColor whiteColor];
        self.viewModel.isGoodsCollect = YES;
        [self.tableView reloadData];
    } forControlEvents:UIControlEventTouchUpInside];

    [self.shopCollectButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.selectLine.frame = CGRectMake( KscreenW/2, 28, KscreenW/2, 2);
        self.shopCollectButton.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        self.goodsCollectButton.backgroundColor = [UIColor whiteColor];
        self.viewModel.isGoodsCollect = NO;
        [self.tableView reloadData];
    } forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - dataSource method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.viewModel.isGoodsCollect) {
        return self.viewModel.goodsDataArray.count;
    }else {
        return self.viewModel.shopDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.viewModel.isGoodsCollect) {
        TSGoodsCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GoodsCollectTableViewCellIdentifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TSGoodsCollectTableViewCell" owner:nil options:nil]lastObject];
            UIView *backView = [[UIView alloc] init];
            backView.backgroundColor = [UIColor colorWithHexString:@"1ca6df"];
            cell.selectedBackgroundView = backView;
        }
        
        TSCollectGoodsModel *model = self.viewModel.goodsDataArray[indexPath.row];
        [cell configureGoodsCollectCell:model];

        return cell;

    }else {
        TSShopCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ShopCollectTableViewCellIdentifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TSShopCollectTableViewCell" owner:nil options:nil]lastObject];
            UIView *backView = [[UIView alloc] init];
            backView.backgroundColor = [UIColor colorWithHexString:@"1ca6df"];
            cell.selectedBackgroundView = backView;
        }
        TSCollectionShopModel *model = self.viewModel.shopDataArray[indexPath.row];
        [cell configureShopCell:model];
        return cell;
    }
}
#pragma mark - tableview  delegate
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *params;
        if (self.viewModel.isGoodsCollect) {
            TSCollectGoodsModel *model = self.viewModel.goodsDataArray[indexPath.row];
            params = @{@"id" : [NSString stringWithFormat:@"%d",model.c_id]};
        }else {
            TSCollectionShopModel *model = self.viewModel.shopDataArray[indexPath.row];
            params = @{@"id" : [NSString stringWithFormat:@"%d",model.C_ID]};
        }
        [TSHttpTool getWithUrl:CollectDelete_URL params:params withCache:NO success:^(id result) {
            if ([result[@"success"] intValue] == 1) {
                NSLog(@"删除收藏：%@",result);
                [UIView animateWithDuration:0.25 animations:^{
                } completion:^(BOOL finished) {
                    if (finished) {
                        if (self.viewModel.isGoodsCollect) {
                            [self.viewModel.goodsDataArray removeObjectAtIndex:indexPath.row];
                        }else {
                            [self.viewModel.shopDataArray removeObjectAtIndex:indexPath.row];
                        }
                        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                    }
                }];
            }
        } failure:^(NSError *error) {
            NSLog(@"删除收藏：%@",error);
        } ];
     }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0){
    return @"删除";
}
@end
