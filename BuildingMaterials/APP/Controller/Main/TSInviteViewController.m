//
//  TSInviteViewController.m
//  BuildingMaterials
//
//  Created by Ariel on 14/10/24.
//  Copyright (c) 2014年 Ariel. All rights reserved.
//

#import "TSInviteViewController.h"
#import "TSInviteModel.h"
#import "TSInviteCell.h"

static NSString * const inviteCellIdentifier = @"inviteCell";

@interface TSInviteViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *inviteTableView;

@end

@implementation TSInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self initializData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initializData{

    NSDictionary *params = @{@"page":@"1"};
    [TSHttpTool getWithUrl:Invite_URL params:params withCache:NO success:^(id result) {
        NSLog(@"招聘:%@",result);
        if (result[@"success"]) {
            for (NSDictionary *oneResult in result[@"result"]) {
                TSInviteModel *model = [[TSInviteModel alloc] init];
                [model setValueForDictionary:oneResult];
                [self.viewModel.dataArray addObject:model];
            }
            [self.inviteTableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"分类:%@",error);
    }];
    
}

#pragma mark - set UI
- (void)setupUI{
    
    [self creatRootView];
    [self createNavigationBarTitle:@"贵州建材网\nwww.xxx.com" leftButtonImageName:nil rightButtonImageName:nil];
    [self.rootView addSubview:self.navigationBar];
    
    self.inviteTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 64, KscreenW, KscreenH - 49 - 64) style:UITableViewStylePlain];

    self.inviteTableView.rowHeight = 80;
    [self.rootView addSubview:self.inviteTableView];
    [self.view addSubview:self.inviteTableView];
    self.inviteTableView.delegate = self;
    self.inviteTableView.dataSource = self;
}
#pragma mark - tableView delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSInviteCell *cell = [tableView dequeueReusableCellWithIdentifier:inviteCellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSInviteCell" owner:nil options:nil]lastObject];
    }
    cell.contentView.backgroundColor = [UIColor colorWithHexString:@"f1f2f6"];
    TSInviteModel *model = self.viewModel.dataArray[indexPath.row];
    [cell configureCellWithModel:model];
    return cell;
}

@end
