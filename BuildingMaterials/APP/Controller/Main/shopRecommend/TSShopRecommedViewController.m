//
//  TSShopRecommedViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/11/9.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSShopRecommedViewController.h"
#import "TSShopRecommedDetailTableViewCell.h"
#import "TSShopDetailViewController.h"
#import "TSShopDetailViewModel.h"

static NSString *const ShopRecommedDetailTableViewCell = @"ShopRecommedDetailTableViewCell";

@interface TSShopRecommedViewController ()<UITableViewDelegate>
@property (nonatomic, strong) TSArrayDataSource *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableDataArray;

@end

@implementation TSShopRecommedViewController

#pragma mark - controller methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeData];
    [self setupUI];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)initializeData{
    self.tableDataArray = [[NSMutableArray alloc] initWithObjects:@"莫非瓷砖商家",@"莫非瓷砖商家",@"莫非瓷砖商家",@"莫非瓷砖",@"莫非瓷砖商家",@"莫非瓷砖商家", nil];
}
#pragma mark - set up UI
- (void)setupUI{
    
    [self creatRootView];
    [self createNavigationBarTitle:@"商家推荐" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    [self.rootView addSubview:self.navigationBar];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KnaviBarHeight, KscreenW, KscreenH - KnaviBarHeight - STATUS_BAR_HEGHT - KbottomBarHeight) style:UITableViewStylePlain];
    self.tableView.rowHeight = 125;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    CellConfigureBlock configureBlock = ^(TSShopRecommedDetailTableViewCell *cell,id taskModel,NSIndexPath *indexPath){
        [cell configureCellWithModel:taskModel indexPath:indexPath];
    };
    
    
    self.dataSource = [[TSArrayDataSource alloc] initWithNibName:@"TSShopRecommedDetailTableViewCell" items:self.tableDataArray cellIdentifier:ShopRecommedDetailTableViewCell configureCellBlock:configureBlock];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    [self.rootView addSubview:self.tableView];
    
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TSShopDetailViewModel *viewModel = [[TSShopDetailViewModel alloc] init];
    TSShopDetailViewController *shopDetailVC = [[TSShopDetailViewController alloc] initWithViewModel:viewModel];
    [self.navigationController pushViewController:shopDetailVC animated:YES];
}
@end
