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

@end

@implementation TSCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - set UI
- (void)setupUI{
    
    [self creatRootView];
    [self createNavigationBarTitle:@"分类" leftButtonImageName:nil rightButtonImageName:nil];
    [self.rootView addSubview:self.navigationBar];
    
    self.categrayTable = [[UITableView alloc] initWithFrame:CGRectMake( 0, KnaviBarHeight, KscreenW, KscreenH - KnaviBarHeight - KbottomBarHeight - STATUS_BAR_HEGHT) style:UITableViewStylePlain];
    self.categrayTable.delegate = self;
    self.categrayTable.dataSource = self;
    self.categrayTable.showsVerticalScrollIndicator = NO;
    self.categrayTable.rowHeight = 44;
    [self.rootView addSubview:_categrayTable];

}

#pragma mark - tableView delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"商品";
    return cell;
}

@end
