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

static NSString *const CollectTableViewCellIdentifier = @"CollectTableViewCellIdentifier";

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
    [self initializeData];
    [self setupUI];
    [self blindActionHandler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initializeData{
}
#pragma mark - set up UI
- (void)setupUI{
    [self createNavigationBarTitle:@"我的收藏" leftButtonImageName:@"Previous" rightButtonImageName:nil];
    self.navigationBar.frame = CGRectMake( 0, STATUS_BAR_HEGHT, KscreenW, 44);
    [self.view addSubview:self.navigationBar];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
- (void)blindViewModel{
}

- (void)blindActionHandler{
}

#pragma mark - dataSource method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectTableViewCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CollectTableViewCellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.numberOfLines = 0;
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake( 0, tableView.rowHeight - 1, KscreenW, 1)];
        line.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:line];
        
        
    }
    //    TSAddressModel *model = self.viewModel.addressArray[indexPath.row];
    //    cell.textLabel.text = model.addressMain;
    return cell;
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
