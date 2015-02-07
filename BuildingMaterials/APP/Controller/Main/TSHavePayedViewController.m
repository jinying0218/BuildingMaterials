//
//  TSHavePayedViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 15/2/7.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "TSHavePayedViewController.h"
#import "TSHavePayedViewModel.h"
#import "TSHavePayedTableViewCell.h"

static NSString *const HavePayedTableViewCellIdendifier = @"HavePayedTableViewCellIdendifier";

@interface TSHavePayedViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) TSHavePayedViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TSHavePayedViewController
- (instancetype)initWithViewModel:(TSHavePayedViewModel *)viewModel{
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
}
- (void)configureUI{
    self.tabBarController.tabBar.hidden =  YES;
    
    [self createNavigationBarTitle:@"已付订单" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

}

- (void)blindViewModel{
    
}
- (void)blindActionHandler{
}

#pragma mark - dataSource method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 128;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  2;
    //[self.viewModel.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSHavePayedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HavePayedTableViewCellIdendifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSHavePayedTableViewCell" owner:nil options:nil]lastObject];
    }
    
    //    TSShopCarModel *model = self.viewModel.dataArray[indexPath.row];
    //    TSShopCarCellSubviewModel *subviewModel = self.viewModel.subviewModels[indexPath.row];
    //    [cell attachViewModel:subviewModel];
    //    [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"not_load"]];
    //    cell.goodsName.text = @"test";
    return cell;
}

@end
