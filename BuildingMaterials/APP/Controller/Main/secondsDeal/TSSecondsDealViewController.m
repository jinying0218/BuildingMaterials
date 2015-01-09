//
//  TSSecondsDealViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/11/1.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSSecondsDealViewController.h"
#import "TSSecondsDealDetailTableViewCell.h"
#import "TSSecondsDealViewModel.h"

#import "TSSecondDealDetailViewController.h"
#import "TSSecondDealDetailViewModel.h"

static NSString *const SecondsDealDetailTableViewCell = @"SecondsDealDetailTableViewCell";

@interface TSSecondsDealViewController ()<UITableViewDelegate>
@property (nonatomic, strong) TSSecondsDealViewModel *viewModel;
@property (nonatomic, strong) TSArrayDataSource *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableDataArray;

@end

@implementation TSSecondsDealViewController
#pragma mark - controller methods
- (instancetype)initWithViewModel:(TSSecondsDealViewModel *)viewModel
{
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
    self.tableDataArray = [[NSMutableArray alloc] initWithObjects:@"莫非瓷砖",@"莫非瓷砖",@"莫非瓷砖",@"莫非瓷砖",@"莫非瓷砖",@"莫非瓷砖", nil];
}
#pragma mark - set up UI
- (void)setupUI{
    
    [self creatRootView];
    [self createNavigationBarTitle:@"掌上秒杀" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    [self.rootView addSubview:self.navigationBar];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KnaviBarHeight, KscreenW, KscreenH - KnaviBarHeight - STATUS_BAR_HEGHT) style:UITableViewStylePlain];
    self.tableView.rowHeight = 125;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    CellConfigureBlock configureBlock = ^(TSSecondsDealDetailTableViewCell *cell,id taskModel,NSIndexPath *indexPath){
        [cell configureCellWithModel:taskModel indexPath:indexPath];
    };
    
    
    self.dataSource = [[TSArrayDataSource alloc] initWithNibName:@"TSSecondsDealDetailTableViewCell" items:self.tableDataArray cellIdentifier:SecondsDealDetailTableViewCell configureCellBlock:configureBlock];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    [self.rootView addSubview:self.tableView];
    
}

#pragma mark - tableView delegateMethod
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TSSecondDealDetailViewModel *viewModel = [[TSSecondDealDetailViewModel alloc] init];
    TSSecondDealDetailViewController *secondDealDetailVC = [[TSSecondDealDetailViewController alloc] initWithViewModel:viewModel];
    [self.navigationController pushViewController:secondDealDetailVC animated:YES];
}
@end
