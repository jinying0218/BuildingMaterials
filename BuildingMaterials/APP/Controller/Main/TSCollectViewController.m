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
#import "TSCollectModel.h"

#import "TSGoodsCollectTableViewCell.h"

static NSString *const GoodsCollectTableViewCellIdentifier = @"GoodsCollectTableViewCellIdentifier";

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
    [TSHttpTool getWithUrl:Collect_URL params:params withCache:NO success:^(id result) {
        NSLog(@"收藏列表:%@",result);
        if ([result[@"success"] intValue] == 1) {
            for (NSDictionary *dict in result[@"goods2"]) {
                TSCollectModel *model = [[TSCollectModel alloc]init];
                [model setValueWithDict:dict];
                [self.viewModel.dataArray addObject:model];
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
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.viewModel.isGoodsCollect) {
        TSGoodsCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GoodsCollectTableViewCellIdentifier];
        if (!cell) {
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TSGoodsCollectTableViewCell" owner:nil options:nil]lastObject];
            }
            
            TSCollectModel *model = self.viewModel.dataArray[indexPath.row];
            [cell configureGoodsCollectCell:model];
            return cell;
        }
        //    TSAddressModel *model = self.viewModel.addressArray[indexPath.row];
        //    cell.textLabel.text = model.addressMain;
        return cell;

    }else {
        TSGoodsCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GoodsCollectTableViewCellIdentifier];
        if (!cell) {
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"TSInviteCell" owner:nil options:nil]lastObject];
            }
            
//            TSInviteModel *model = self.viewModel.dataArray[indexPath.row];
//            [cell configureCellWithModel:model];
            return cell;
            
            
        }
        //    TSAddressModel *model = self.viewModel.addressArray[indexPath.row];
        //    cell.textLabel.text = model.addressMain;
        return cell;
    }
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
