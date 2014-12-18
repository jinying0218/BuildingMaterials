//
//  TSGoodsExchangeViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/11/9.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSGoodsExchangeViewController.h"
#import "TSGoodsExchangeDetailTableViewCell.h"

static NSString *const GoodsExchangeDetailTableViewCell = @"GoodsExchangeDetailTableViewCell";

@interface TSGoodsExchangeViewController ()<UITableViewDelegate>
@property (nonatomic, strong) TSArrayDataSource *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableDataArray;
@end

@implementation TSGoodsExchangeViewController

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
    [self createNavigationBarTitle:@"以物换物" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    [self.rootView addSubview:self.navigationBar];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KnaviBarHeight, KscreenW, KscreenH - KnaviBarHeight - STATUS_BAR_HEGHT - KbottomBarHeight) style:UITableViewStylePlain];
    self.tableView.rowHeight = 125;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    CellConfigureBlock configureBlock = ^(TSGoodsExchangeDetailTableViewCell *cell,id taskModel,NSIndexPath *indexPath){
        [cell configureCellWithModel:taskModel indexPath:indexPath];
    };
    
    
    self.dataSource = [[TSArrayDataSource alloc] initWithNibName:@"TSGoodsExchangeDetailTableViewCell" items:self.tableDataArray cellIdentifier:GoodsExchangeDetailTableViewCell configureCellBlock:configureBlock];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    [self.rootView addSubview:self.tableView];
    
}

@end