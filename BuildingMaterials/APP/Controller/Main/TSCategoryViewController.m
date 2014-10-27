//
//  TSCategoryViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/24.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSCategoryViewController.h"

@interface TSCategoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *categrayTable;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) NSMutableArray *detailArray;

@end

@implementation TSCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializData];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - initializData
- (void)initializData{
    self.dataSourceArray = [[NSMutableArray alloc] initWithObjects:@"地板",@"瓷砖",@"整体厨房",@"洁具/卫浴", nil];
    self.detailArray = [[NSMutableArray alloc] initWithObjects:@"百博地板、百博地板、百博地板",@"王者、王者、王者",@"欧派橱柜、欧派橱柜",@"朝阳卫浴、朝阳卫浴、朝阳卫浴", nil];

}
#pragma mark - set UI
- (void)setupUI{
    
    [self creatRootView];
    self.navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, KnaviBarHeight)];
    self.navigationBar.backgroundColor = [UIColor colorWithHexString:@"#1CA6DF"];
    self.navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.rootView addSubview:self.navigationBar];
    
    UIView *searchBg = [[UIView alloc] initWithFrame:CGRectMake( 10, 8, KscreenW - 80, 28)];
    searchBg.backgroundColor = [UIColor whiteColor];
    searchBg.layer.cornerRadius = 5;
    [self.navigationBar addSubview:searchBg];
    
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"search_leftView"]];
    leftView.frame = CGRectMake( 10, 4, 20, 20);
    [searchBg addSubview:leftView];
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake( CGRectGetMaxX(leftView.frame) + 10, 0, searchBg.frame.size.width - 40, 28)];
    self.searchTextField.placeholder = @"请输入材料商品关键字";
    self.searchTextField.backgroundColor = [UIColor clearColor];
    [searchBg addSubview:self.searchTextField];
    
    UIButton *naviRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [naviRightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [naviRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [naviRightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    naviRightBtn.frame = CGRectMake( CGRectGetMaxX(searchBg.frame) + 10, 12, 60, 20);
    [self.navigationBar addSubview:naviRightBtn];
    
    [naviRightBtn bk_addEventHandler:^(id sender) {
        
    } forControlEvents:UIControlEventTouchUpInside];

    
    self.categrayTable = [[UITableView alloc] initWithFrame:CGRectMake( 0, KnaviBarHeight, KscreenW, KscreenH - KnaviBarHeight - KbottomBarHeight - STATUS_BAR_HEGHT) style:UITableViewStylePlain];
    self.categrayTable.delegate = self;
    self.categrayTable.dataSource = self;
    self.categrayTable.showsVerticalScrollIndicator = NO;
    self.categrayTable.rowHeight = 90;
    self.categrayTable.separatorInset = UIEdgeInsetsMake( 0, 0, 0, 0);
    [self.rootView addSubview:_categrayTable];

}

#pragma mark - tableView delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamedString:@"分类2111111111_19"];
    cell.textLabel.text = self.dataSourceArray[indexPath.row];
    cell.detailTextLabel.text = self.detailArray[indexPath.row];
    return cell;
}

@end
