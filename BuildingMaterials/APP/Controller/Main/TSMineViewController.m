//
//  TSMineViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/24.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSMineViewController.h"

@interface TSMineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *iConArray;
@property (nonatomic, strong) NSMutableArray *titleArray;
@end

@implementation TSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializData];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - initialize Data
- (void)initializData{
//    NSArray *imageArray1 = @[@"mine_forum",@"mine_invite"];
//    NSArray *imageArray = @[@"mine_waitForpay",@"mine_payed",@"mine_addressManager",@"mine_changePassword",@"mine_checknew"];
//    NSArray *imageArray3 = @[];

//    NSArray *titleArray1 = @[@"我的论坛",@"我的招聘"];
//    NSArray *titleArray2 = @[@"待付款",@"已付款",@"收货地址管理",@"修改密码",@"检测版本"];
//    NSArray *titleArray3 = @[];
    self.iConArray = [NSMutableArray arrayWithObjects:@"mine_waitForpay",@"mine_payed",@"mine_addressManager",@"mine_changePassword",@"mine_checknew", nil];
    self.titleArray = [NSMutableArray arrayWithObjects:@"待付款",@"已付款",@"收货地址管理",@"修改密码",@"检测版本", nil];

}
#pragma mark - set UI
- (void)setupUI{
    
    [self creatRootView];
    self.rootView.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
    [self createNavigationBarTitle:@"我的信息" leftButtonImageName:nil rightButtonImageName:nil];
    [self.rootView addSubview:self.navigationBar];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, KnaviBarHeight, KscreenW, KscreenH - STATUS_BAR_HEGHT - KnaviBarHeight - KbottomBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 44;
    [self.rootView addSubview:self.tableView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, KscreenW, 44)];
    footerView.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
    self.tableView.tableFooterView = footerView;
    
    UIButton *quiteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quiteBtn.frame = CGRectMake( 20, 0, KscreenW - 40, 34);
    quiteBtn.layer.cornerRadius = 5;
    quiteBtn.backgroundColor = [UIColor colorWithHexString:@"1CA6DF"];
    [quiteBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    quiteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [quiteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quiteBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [quiteBtn bk_addEventHandler:^(id sender) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:KaccountDataPath]) {
            [fileManager removeItemAtPath:KaccountDataPath error:nil];
        }
        [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:quiteBtn];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, KscreenW, 150)];
    self.tableView.tableHeaderView = headerView;
    
    UIImageView *halfHeaderBg = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"mine_headerBg"]];
    halfHeaderBg.frame = CGRectMake( 0, 0, KscreenW, 90);
    [headerView addSubview:halfHeaderBg];
    
    UIImageView *headImage = [[UIImageView alloc] initWithImage:[UIImage imageNamedString:@"mine_headImage"]];
    headImage.frame = CGRectMake( (KscreenW - 44)/2, 10, 44, 44);
    [halfHeaderBg addSubview:headImage];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake( 0, CGRectGetMaxY(headImage.frame) + 5, KscreenW, 21)];
    phoneLabel.text = @"15840806085";
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.textColor = [UIColor whiteColor];
    phoneLabel.font = [UIFont systemFontOfSize:15];
    [halfHeaderBg addSubview:phoneLabel];
    
    UIButton *shopCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shopCarBtn.frame = CGRectMake( 0, 90, KscreenW/2, 60);
    [shopCarBtn setImage:[UIImage imageNamedString:@"mine_shopBag"] forState:UIControlStateNormal];
    [shopCarBtn setImageEdgeInsets:UIEdgeInsetsMake( 15, 50, 15, 50)];
    [shopCarBtn bk_addEventHandler:^(id sender) {
        NSLog(@"购物车");
    } forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:shopCarBtn];
    
    UIButton *collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectionBtn.frame = CGRectMake( KscreenW/2, 90, KscreenW/2, 60);
    [collectionBtn setImage:[UIImage imageNamedString:@"mine_collection"] forState:UIControlStateNormal];
    [collectionBtn setImageEdgeInsets:UIEdgeInsetsMake( 15, 60, 15, 60)];
    [collectionBtn bk_addEventHandler:^(id sender) {
        NSLog(@"收藏");
    } forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:collectionBtn];

    UILabel *seperatLineV = [[UILabel alloc] initWithFrame:CGRectMake( KscreenW/2, 90, 1, 60)];
    seperatLineV.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    [headerView addSubview:seperatLineV];
}

#pragma mark - tableview  delegate & dataSource method
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    NSArray *array = @[@"0",@"0",@"10"];
    return 10;
    //[array[section] intValue];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSArray *array = @[@"2",@"3",@"2"];
    return self.titleArray.count;
    //[array[section] intValue];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
//    if (indexPath.section == 1 && indexPath.row == 0) {
//        UILabel *accessLabel = [[UILabel alloc] init];
//        accessLabel.frame = CGRectMake( KscreenW - 20, 8, 15, 28);
//        accessLabel.text = @"2";
//        accessLabel.textColor = [UIColor colorWithHexString:@"00A8E0"];
//        cell.accessoryView = accessLabel;
//    }
//    if (indexPath.section == 1 && indexPath.row == 1) {
//        UILabel *accessLabel = [[UILabel alloc] init];
//        accessLabel.frame = CGRectMake( KscreenW - 20, 8, 15, 28);
//        accessLabel.text = @"0";
//        accessLabel.textColor = [UIColor colorWithHexString:@"00A8E0"];
//        cell.accessoryView = accessLabel;
//    }
//    UILabel *accessLabel = [[UILabel alloc] init];
//    accessLabel.frame = CGRectMake( KscreenW - 20, 8, 15, 28);
//    accessLabel.text = @"0";
//    accessLabel.textColor = [UIColor colorWithHexString:@"00A8E0"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    cell.textLabel.text = self.titleArray[indexPath.row];
//    cell.textLabel.text = self.titleArray[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.imageView.image = [UIImage imageNamedString:self.iConArray[indexPath.row]];
    return cell;
}
@end
