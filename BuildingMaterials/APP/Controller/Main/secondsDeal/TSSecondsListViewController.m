//
//  TSSecondsDealViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/11/1.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSSecondsListViewController.h"
#import "TSSecondsDealDetailTableViewCell.h"
#import "TSSecondsDealViewModel.h"
#import "ClockView.h"

//#import "TSSecondDealDetailViewController.h"
//#import "TSSecondDealDetailViewModel.h"
#import "TSSecKillModel.h"

#import "TSGoodsDetailViewModel.h"
#import "TSGoodsDetailViewController.h"
#import "ClockView.h"

static NSString *const SecondsDealDetailTableViewCell = @"SecondsDealDetailTableViewCell";

@interface TSSecondsListViewController ()<UITableViewDelegate>
@property (nonatomic, strong) TSSecondsDealViewModel *viewModel;
@property (nonatomic, strong) TSArrayDataSource *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableDataArray;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *overLabel;  //即将结束 label，显示秒杀是否结束
@property (weak, nonatomic) IBOutlet UILabel *secondsDealLabel;
@property (nonatomic, strong) ClockView *endDateView;

@end

@implementation TSSecondsListViewController
#pragma mark - controller methods
- (instancetype)initWithViewModel:(TSSecondsDealViewModel *)viewModel{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeData];
    [self setupUI];
    self.tabBarController.tabBar.hidden =  YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)initializeData{
    //秒杀
    [TSHttpTool getWithUrl:Frist_SecKillLoad_URL params:nil withCache:NO success:^(id result) {
                NSLog(@"秒杀列表:%@",result);
        if ([result[@"success"] intValue] == 1) {
            NSArray *goods_result = result[@"goods_result"];
            for (NSDictionary *oneGoodsResult in goods_result) {
                TSSecKillModel *model = [[TSSecKillModel alloc] init];
                [model setValueForDictionary:oneGoodsResult];
                model.END_TIME = result[@"result"][@"END_TIME"];
                model.SecondsDeal_EventID = [[result[@"result"] objectForKey:@"ID"] intValue];
                model.STATUS = [[result[@"result"] objectForKey:@"STATUS"] intValue];
                [self.viewModel.dataArray addObject:model];
                
                self.viewModel.endDate = model.END_TIME;
            }
            [self layoutSubviews];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"Frist_SecKillLoad_URL:%@",error);
    }];

}
#pragma mark - set up UI
- (void)setupUI{
    
    [self creatRootView];
    [self createNavigationBarTitle:@"掌上秒杀" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    [self.rootView addSubview:self.navigationBar];
    
    self.headerView.frame = CGRectMake( 0, CGRectGetMaxY(self.navigationBar.frame), KscreenW, 40);
    [self.rootView addSubview:self.headerView];
   
    self.endDateView = [[ClockView alloc] initWithFrame:CGRectMake( CGRectGetMaxX(self.secondsDealLabel.frame) + 10, 10, 110, 20) style:ClockStyleDefault];
    @weakify(self);
    self.endDateView.Activate = ^(){
        @strongify(self);
        self.overLabel.text = @"秒杀结束";
    };

    [self.headerView addSubview:self.endDateView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KnaviBarHeight + 40, KscreenW, KscreenH - KnaviBarHeight - STATUS_BAR_HEGHT - 40) style:UITableViewStylePlain];
    self.tableView.rowHeight = 125;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    CellConfigureBlock configureBlock = ^(TSSecondsDealDetailTableViewCell *cell,TSSecKillModel *taskModel,NSIndexPath *indexPath){
        [cell configureCellWithModel:taskModel indexPath:indexPath];
        if ([self.overLabel.text isEqualToString:@"秒杀结束"]) {
            cell.secondsBuyButton.enabled = NO;
        }

    };
    
    self.dataSource = [[TSArrayDataSource alloc] initWithNibName:@"TSSecondsDealDetailTableViewCell" items:self.viewModel.dataArray cellIdentifier:SecondsDealDetailTableViewCell configureCellBlock:configureBlock];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    [self.rootView addSubview:self.tableView];
//    self.overLabel.text = @"秒杀结束";
    
}

- (void)layoutSubviews{
//    @weakify(self);
    [self.endDateView setWithEndTime:self.viewModel.endDate];
}
#pragma mark - tableView delegateMethod
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TSSecKillModel *secKillModel = self.viewModel.dataArray[indexPath.row];
    if ([self.overLabel.text isEqualToString:@"秒杀结束"]) {
        [self showProgressHUD:@"秒杀已结束" delay:1];
        return;
    }
    if (secKillModel.haveOver) {
        [self showProgressHUD:@"已抢光了" delay:1];
        return;
    }
    //秒杀
    TSGoodsDetailViewModel *viewModel = [[TSGoodsDetailViewModel alloc] init];
    viewModel.goodsID = secKillModel.goodsId;
    viewModel.isSecondsDeal = YES;
    viewModel.seckillModel = secKillModel;
    TSGoodsDetailViewController *goodsDetailVC = [[TSGoodsDetailViewController alloc] init];
    goodsDetailVC.viewModel = viewModel;
    [self.navigationController pushViewController:goodsDetailVC animated:YES];
//    TSSecondDealDetailViewModel *viewModel = [[TSSecondDealDetailViewModel alloc] init];
//    viewModel.secKillModel = secKillModel;
//    TSSecondDealDetailViewController *secondDealDetailVC = [[TSSecondDealDetailViewController alloc] initWithViewModel:viewModel];
//    [self.navigationController pushViewController:secondDealDetailVC animated:YES];
}
@end
